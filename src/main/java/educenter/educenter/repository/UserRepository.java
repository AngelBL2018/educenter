package educenter.educenter.repository;

import educenter.educenter.model.User;
import educenter.educenter.model.UserType;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserRepository extends JpaRepository<User, Integer> {
    User findUserByEmail(String email);
    List<User> findUsersByUserType(UserType type);

}
