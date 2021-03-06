package educenter.educenter.model;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.List;


@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name = "subject")
public class Subject{

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column

   private int id;
    @Column
   private String name;
    @Column
   private int duration;
    @Column
   private double price;
    @Column
   private String lecturer;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
            name="user_subject",
            joinColumns={@JoinColumn(name = "subject_id", referencedColumnName = "id")},
            inverseJoinColumns={@JoinColumn(name = "user_id", referencedColumnName = "id")})
    private List<User> users;


}
