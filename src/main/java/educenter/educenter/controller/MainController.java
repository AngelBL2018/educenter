package educenter.educenter.controller;


import educenter.educenter.mail.EmailServiceImpl;
import educenter.educenter.model.Subject;
import educenter.educenter.model.User;
import educenter.educenter.model.UserType;
import educenter.educenter.repository.SubjectRepository;
import educenter.educenter.repository.UserRepository;
import educenter.educenter.security.CurrentUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


import java.util.UUID;


@Controller
public class MainController {
    @Autowired
    UserRepository userRepository;
    @Autowired
    PasswordEncoder passwordEncoder;
    @Autowired
    SubjectRepository subjectRepository;
    @Autowired
    EmailServiceImpl emailService;


    @RequestMapping(value = "/loginPage", method = RequestMethod.GET)
    public String loginPage(ModelMap map) {
        map.addAttribute("user", new User());

        return "login";
    }


    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login(@AuthenticationPrincipal UserDetails userDetails) {
        User user = ((CurrentUser) userDetails).getUser();
        if (user.getUserType() == UserType.MANAGER) {
            return "redirect:/manager";
        }
        return "redirect:/student";
    }

    @RequestMapping(value = "/manager", method = RequestMethod.GET)
    public String manager(ModelMap map,
                          @RequestParam(value = "student", required = false) Integer studentId,
                          @RequestParam(value = "userId", required = false) Integer userId) {
        if (studentId != null && !studentId.equals("")) {
            User user = userRepository.findOne(studentId);
            map.addAttribute("userSubject", user.getSubjects());
            map.addAttribute("userId", studentId);
            map.addAttribute("userFirst", userRepository.findOne(studentId));

        }


        map.addAttribute("subject", new Subject());
        map.addAttribute("user", new User());
        map.addAttribute("subjectList", subjectRepository.findAll());
        map.addAttribute("studentList", userRepository.findUsersByUserType(UserType.STUDENT));

        return "manager";
    }


    @RequestMapping(value = "/student", method = RequestMethod.GET)
    public String student(ModelMap map, @AuthenticationPrincipal UserDetails userDetails,
                          @RequestParam(value = "subjectId", required = false) Integer subjectId,
                          @RequestParam(value = "lastSubjectId", required = false) Integer lastSubjectId,
                          @RequestParam(value = "EachstudentDetails", required = false) Integer EachstudentDetails) {
        User user = ((CurrentUser) userDetails).getUser();

        if (subjectId != null && !subjectId.equals("")) {
            Subject subject = subjectRepository.findOne(subjectId);
            map.addAttribute("studentList", subject.getUsers());
            map.addAttribute("lastSubjectId", subjectId);
        }
        if (lastSubjectId != null && !lastSubjectId.equals("")) {
            Subject subject = subjectRepository.findOne(lastSubjectId);
            map.addAttribute("studentList", subject.getUsers());
            map.addAttribute("lastSubjectId", lastSubjectId);
        }
        if (EachstudentDetails != null && !EachstudentDetails.equals("")) {
            map.addAttribute("userDetail", userRepository.findOne(EachstudentDetails));

        }
        map.addAttribute("subjectList", user.getSubjects());
        map.addAttribute("user", new User());

        return "student";
    }


    @RequestMapping(value = "/addSubject", method = RequestMethod.POST)
    public String addSubject(@ModelAttribute("subject") Subject subject) {
        subjectRepository.save(subject);
        return "redirect:/manager";
    }

    @RequestMapping(value = "/addStudent", method = RequestMethod.POST)
    public String addStudent(@ModelAttribute("user") User user) {
        user.setUserType(UserType.STUDENT);
        user.setToken(UUID.randomUUID().toString());
        String pass = user.getPassword();
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userRepository.save(user);
        String subject = String.format("Welcome %s to our education center", user.getName());
        String url = String.format("http://localhost:8080/verify?token=%s&email=%s", user.getToken(), user.getEmail());
        String text = String.format("Your password is %s, Please visit by link for activating your account %s", pass, url);
        emailService.sendSimpleMessage(user.getEmail(), subject, text);

        return "redirect:/manager";
    }

    @RequestMapping(value = "/deleteSubject", method = RequestMethod.GET)
    public String deleteSubject(@RequestParam("subject") int id) {
        subjectRepository.delete(id);
        return "redirect:/manager";
    }


    @RequestMapping(value = "/deleteStudent", method = RequestMethod.GET)
    public String deleteStudent(@RequestParam("student") int id) {
        userRepository.delete(id);
        return "redirect:/manager";
    }


    @RequestMapping(value = "/changeSubjectDetails", method = RequestMethod.GET)
    public String changeSubjectDetails(@RequestParam("subject") int id, @RequestParam(value = "price", required = false) Double price,
                                       @RequestParam(value = "duration", required = false) Integer duration,
                                       @RequestParam(value = "lecturer", required = false) String lecturer) {
        Subject subject = subjectRepository.findOne(id);
        if (price != null) {
            subject.setPrice(price);
        }
        if (duration != null) {
            subject.setDuration(duration);
        }
        if (lecturer != null && !lecturer.equals("")) {
            subject.setLecturer(lecturer);
        }
        subjectRepository.save(subject);
        return "redirect:/manager";
    }


    @RequestMapping(value = "/changeStudentDetails", method = RequestMethod.GET)
    public String changeStudentDetails(@RequestParam("student") int id,
                                       @RequestParam(value = "email", required = false) String email,
                                       @RequestParam(value = "password", required = false) String password) {
        User user = userRepository.findOne(id);


        if (email != null && !email.equals("")) {
            user.setEmail(email);
        }
        if (password != null && !password.equals("")) {
            user.setPassword(passwordEncoder.encode(password));
        }
        userRepository.save(user);
        return "redirect:/manager";
    }


    @RequestMapping(value = "/changeMyDetails", method = RequestMethod.GET)
    public String changeMyDetails(@AuthenticationPrincipal UserDetails userDetails,
                                  @RequestParam(value = "email", required = false) String email,
                                  @RequestParam(value = "password", required = false) String password) {

        User user = ((CurrentUser) userDetails).getUser();

        if (email != null && !email.equals("")) {
            user.setEmail(email);
        }
        if (password != null && !password.equals("")) {
            user.setPassword(passwordEncoder.encode(password));
        }
        userRepository.save(user);
        return "redirect:/student";


    }


    @RequestMapping(value = "/addStudentSubject", method = RequestMethod.GET)
    public String addStudentSubject(@RequestParam("student") int studentId, @RequestParam("subject") int subjectId) {
        User user = userRepository.findOne(studentId);
        Subject subject = subjectRepository.findOne(subjectId);
        user.getSubjects().add(subject);
        userRepository.save(user);

        return "redirect:/manager";
    }


    @RequestMapping(value = "/deleteSubjectFromStudentAtLast", method = RequestMethod.GET)
    public String deleteSubjectFromStudentAtLast(@RequestParam(value = "subject", required = false) Integer subjectId,
                                                 @RequestParam("userId") int id) {
        if (subjectId != null && !subjectId.equals("")) {
            User user = userRepository.findOne(id);
            Subject subject = subjectRepository.findOne(subjectId);
            user.getSubjects().remove(subject);
            userRepository.save(user);
            return "redirect:/manager";
        }

        return "redirect:/manager";
    }

    @RequestMapping(value = "/verify", method = RequestMethod.GET)
    public String verify(@RequestParam("token") String token, @RequestParam("email") String email) {
        User user = userRepository.findUserByEmail(email);
        if (user != null) {
            if (user.getToken() != null && user.getToken().equals(token)) {
                user.setVerify(true);
                user.setToken(null);
                userRepository.save(user);
            }
        }
        return "redirect:/loginPage";
    }


}
