package educenter.educenter.repository;

import educenter.educenter.model.Subject;
import educenter.educenter.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface SubjectRepository extends JpaRepository<Subject, Integer> {

}
