/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.loyalty;

import java.util.Date;

/**
 *
 * @author Admin
 */
public class User {
int pk_user_id,update_user_id;
String username,password,real_name,user_type;
Date user_update_date;

    public User() {
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getPk_user_id() {
        return pk_user_id;
    }

    public void setPk_user_id(int pk_user_id) {
        this.pk_user_id = pk_user_id;
    }

    public String getReal_name() {
        return real_name;
    }

    public void setReal_name(String real_name) {
        this.real_name = real_name;
    }

    public int getUpdate_user_id() {
        return update_user_id;
    }

    public void setUpdate_user_id(int update_user_id) {
        this.update_user_id = update_user_id;
    }

    public String getUser_type() {
        return user_type;
    }

    public void setUser_type(String user_type) {
        this.user_type = user_type;
    }

    public Date getUser_update_date() {
        return user_update_date;
    }

    public void setUser_update_date(Date user_update_date) {
        this.user_update_date = user_update_date;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @Override
    public String toString() {
        return "User{" + "pk_user_id=" + pk_user_id + "update_user_id=" + update_user_id + "username=" + username + "password=" + password + "real_name=" + real_name + "user_type=" + user_type + "user_update_date=" + user_update_date + '}';
    }



}
