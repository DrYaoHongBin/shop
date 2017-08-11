package com.shop.model.admin;

import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import java.util.List;

/**
 * 一级类目实体
 */
@Table(name = "category_one")
public class CategoryOne {

    /**
     * 一级类目主键
     */
    @Id
    private Integer categoryOneId;

    /**
     * 一级类目名字
     */
    private String name;

    @Transient
    private List<CategoryTwo> categoryTwoList;

    public CategoryOne(Integer categoryOneId, String name, List<CategoryTwo> categoryTwoList) {
        this.categoryOneId = categoryOneId;
        this.name = name;
        this.categoryTwoList = categoryTwoList;
    }

    @Override
    public String toString() {
        return "CategoryOne{" +
                "categoryOneId=" + categoryOneId +
                ", name='" + name + '\'' +
                ", categoryTwoList=" + categoryTwoList +
                '}';
    }

    public List<CategoryTwo> getCategoryTwoList() {
        return categoryTwoList;
    }

    public void setCategoryTwoList(List<CategoryTwo> categoryTwoList) {
        this.categoryTwoList = categoryTwoList;
    }


    public CategoryOne() {
        super();
    }

    public Integer getCategoryOneId() {
        return categoryOneId;
    }

    public void setCategoryOneId(Integer categoryOneId) {
        this.categoryOneId = categoryOneId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}