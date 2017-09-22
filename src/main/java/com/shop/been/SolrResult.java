package com.shop.been;

import java.util.List;

/**
 * <p>Description:solr查询结果的封装</p>
 *
 * @Author 姚洪斌
 * @Date 2017/9/20 13:08
 */
public class SolrResult<T> {
    /**
     * 根据solr检索库查询出来的信息
     */
    private List<T> list ;

    /**
     * 查询出来的总页数
     */
    private Integer pages;

    /**
     * 上一页
     */
    private Integer prePage;

    /**
     * 下一页
     */
    private Integer nextPage;

    /**
     * 当前页
     */
    private Integer pageNum;

    public List<T> getList() {
        return list;
    }

    /**
     * 查询出来的总记录数
     */
    private Long ResultCount;

    public void setList(List<T> list) {
        this.list = list;
    }

    public Integer getPages() {
        return pages;
    }

    public void setPages(Integer pages) {
        this.pages = pages;
    }

    public Integer getPrePage() {
        return prePage;
    }

    public void setPrePage(Integer prePage) {
        this.prePage = prePage;
    }

    public Integer getNextPage() {
        return nextPage;
    }

    public void setNextPage(Integer nextPage) {
        this.nextPage = nextPage;
    }

    public Integer getPageNum() {
        return pageNum;
    }

    public void setPageNum(Integer pageNum) {
        this.pageNum = pageNum;
    }

    public Long getResultCount() {
        return ResultCount;
    }

    public void setResultCount(Long resultCount) {
        ResultCount = resultCount;
    }

    public SolrResult() {
    }

    public SolrResult(List<T> list, Integer pages, Integer prePage, Integer nextPage, Integer pageNum, Long resultCount) {
        this.list = list;
        this.pages = pages;
        this.prePage = prePage;
        this.nextPage = nextPage;
        this.pageNum = pageNum;
        ResultCount = resultCount;
    }
}
