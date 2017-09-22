package com.shop.dao.solr;

import com.shop.been.SolrResult;
import com.shop.model.merchant.Item;
import org.apache.solr.client.solrj.SolrQuery;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * <p>Description:</p>
 *
 * @Author 姚洪斌
 * @Date 2017/9/18 17:03
 */
public interface ItemSearchDao {

    /**
     * 根据搜索框的内容从solr检索出相关的商品信息
     * @param solrQuery
     * @return
     */
    SolrResult searchItemByName(SolrQuery solrQuery);
}
