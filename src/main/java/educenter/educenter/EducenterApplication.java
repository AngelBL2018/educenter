package educenter.educenter;

import educenter.educenter.model.User;
import educenter.educenter.model.UserType;
import educenter.educenter.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

import javax.swing.plaf.basic.BasicEditorPaneUI;

@SpringBootApplication
public class EducenterApplication implements CommandLineRunner {
    @Autowired
    UserRepository userRepository;


    public static void main(String[] args) {
        SpringApplication.run(EducenterApplication.class, args);
    }


    @Bean

    public ViewResolver viewResolver() {
        InternalResourceViewResolver bean = new InternalResourceViewResolver();
        bean.setViewClass(JstlView.class);
        bean.setPrefix("/WEB-INF/");
        bean.setSuffix(".jsp");
        return bean;
    }


    @Override
    public void run(String... strings) throws Exception {
        User user = User.builder()
                .name("manager")
                .surname("manager")
                .email("manager@mail.com")
                .password(new BCryptPasswordEncoder().encode("12"))
                .userType(UserType.MANAGER).build();
        if (userRepository.findUserByEmail("manager@mail.com") == null) {
            userRepository.save(user);
        }


    }
}
