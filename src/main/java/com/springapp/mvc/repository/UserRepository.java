package com.springapp.mvc.repository;

import com.springapp.mvc.model.User;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

/**
 * Created by atb on 1/22/2015.
 * UserRepository interface extends MongoRepository interface and using Spring data inject by services.
 */
@Repository
public interface UserRepository extends MongoRepository<User,String> {
}
