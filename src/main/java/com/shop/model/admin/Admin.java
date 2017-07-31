package com.shop.model.admin;

import javax.persistence.Id;
import javax.persistence.Table;

@Table(name = "shop_admin")
public class Admin {

    @Id
    private Integer adminId;

    private String name;

    private String account;

    private String password;

    public Admin(Integer adminId, String name, String account, String password) {
        this.adminId = adminId;
        this.name = name;
        this.account = account;
        this.password = password;
    }

    @Override
    public String toString() {
        return "Admin{" +
                "adminId=" + adminId +
                ", name='" + name + '\'' +
                ", account='" + account + '\'' +
                ", password='" + password + '\'' +
                '}';
    }

    public Admin() {
        super();
    }

    public Integer getAdminId() {
        return adminId;
    }

    public void setAdminId(Integer adminId) {
        this.adminId = adminId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}