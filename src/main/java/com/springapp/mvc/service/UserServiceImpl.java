package com.springapp.mvc.service;


import com.springapp.mvc.model.User;
import com.springapp.mvc.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.List;

/**
 * Created by atb on 1/23/2015.
 * this class a service class for userController. Using userpeository provides crud operations for usercontroller.
 */
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository repository;

    @Override
    public List<User> findAll() {
        List<User> userList = repository.findAll();
        return userList;
    }

    @Override
    public void deleteUser(String id) {
        repository.delete(id);
    }

    @Override
    public User save(User user) {
        User saved = repository.save(user);
        return saved;
    }

    @Override
    public User findOne(String id) {
        User user=repository.findOne(id);
        return user;
    }
}
