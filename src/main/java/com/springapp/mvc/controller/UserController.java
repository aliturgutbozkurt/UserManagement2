package com.springapp.mvc.controller;


import com.springapp.mvc.model.User;
import com.springapp.mvc.service.UserService;
import com.springapp.mvc.service.UserServiceImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Created by atb on 1/23/2015.
 * This class is controller class that handles User adding deleting and updating operations for index.jsp view.
 */
@Controller
public class UserController {



    private static final Logger LOG = LoggerFactory.getLogger(UserController.class);
    
    @Autowired
    private UserService userService;

    @RequestMapping(value = {"/save","/"},
            consumes = "application/json",
            produces = "application/json",
            method = {RequestMethod.POST, RequestMethod.PUT})
    @ResponseBody
    public User saveOrUpdate(@RequestBody User user) {
        User saved = userService.save(user);
        LOG.info("Saved : " +saved.getId() +" "+saved.getFirstName()+" "+saved.getSurname()+" "+saved.getTelephone());
        return saved;
    }


    @RequestMapping(value = "/all",
            produces = "application/json",
            method = {RequestMethod.GET})
    @ResponseBody
    public List<User> getAllUsers() {
        List<User> userList = userService.findAll();
        for (User user : userList) {
            LOG.info("Saved : " + user.getId() + " " + user.getFirstName() + " " + user.getSurname() + " " + user.getTelephone());
        }

        return userList;
    }

    @RequestMapping(value = "/delete/{id}",
            produces = "application/json",
            method = {RequestMethod.DELETE})
    @ResponseBody
    public void deleteAUser(@PathVariable("id") String id) {
        User user=userService.findOne(id);
        LOG.info("Will delete : " + user.getId() + " " + user.getFirstName() + " " + user.getSurname() + " " + user.getTelephone());
        userService.deleteUser(id);
        LOG.info("Deleted..");
    }


    @RequestMapping(value = "/")
    public String index(){

        return "index";
    }


}
