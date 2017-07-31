package com.shop.model.admin;

import javax.persistence.Id;
import javax.persistence.Table;

@Table(name = "category_two")
public class CategoryTwo {

    @Id
    private Integer categoryTwoId;

    private String name;

    private Integer categoryOneId;

    public CategoryTwo(Integer categoryTwoId, String name, Integer categoryOneId) {
        this.categoryTwoId = categoryTwoId;
        this.name = name;
        this.categoryOneId = categoryOneId;
    }

    public CategoryTwo() {
        super();
    }

    public Integer getCategoryTwoId() {
        return categoryTwoId;
    }

    public void setCategoryTwoId(Integer categoryTwoId) {
        this.categoryTwoId = categoryTwoId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getCategoryOneId() {
        return categoryOneId;
    }

    public void setCategoryOneId(Integer categoryOneId) {
        this.categoryOneId = categoryOneId;
    }
}