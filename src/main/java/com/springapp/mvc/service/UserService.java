package com.springapp.mvc.service;


import com.springapp.mvc.model.User;

import java.util.List;

/**
 * Created by atb on 1/23/2015.
 * This interface is for UserserviceImpl class defining crud operations.
 */

public interface UserService {

    public List<User> findAll();
    public void deleteUser(String id);
    public User save(User user);
    public User findOne(String id);

}
