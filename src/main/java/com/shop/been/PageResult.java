package com.shop.been;

/**
 * <p>Description:异步分页结果包装</p>
 *
 * @Author 姚洪斌
 * @Date 2017/8/5 20:50
 */
public class PageResult {

    /**
     * 查询结果拼接的html代码
     */
    private String message;

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

    /**
     * 当前页的的条数
     */
    private Integer size;

    public PageResult() { super();
    }

    public PageResult(String message, Integer pages, Integer prePage, Integer nextPage, Integer pageNum, Integer size) {
        this.message = message;
        this.pages = pages;
        this.prePage = prePage;
        this.nextPage = nextPage;
        this.pageNum = pageNum;
        this.size = size;
    }

    @Override
    public String toString() {
        return "PageResult{" +
                "message='" + message + '\'' +
                ", pages=" + pages +
                ", prePage=" + prePage +
                ", nextPage=" + nextPage +
                ", pageNum=" + pageNum +
                ", size=" + size +
                '}';
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
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

    public Integer getSize() {
        return size;
    }

    public void setSize(Integer size) {
        this.size = size;
    }
}
