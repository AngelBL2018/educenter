package educenter.educenter.security;

import educenter.educenter.model.User;
import educenter.educenter.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class CurrentUserDetailService implements UserDetailsService {

    @Autowired
    UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String s) throws UsernameNotFoundException {
       User user =  userRepository.findUserByEmail(s);
       if (user== null){
           throw new UsernameNotFoundException(String.format("User with email %s not found",s));
       }
        return new CurrentUser(user);
    }

}
