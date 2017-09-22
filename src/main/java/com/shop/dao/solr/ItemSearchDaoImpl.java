package com.shop.dao.solr;

import com.shop.been.SolrResult;
import com.shop.model.merchant.Item;
import com.shop.model.merchant.Merchant;
import org.apache.solr.client.solrj.SolrClient;
import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.impl.HttpSolrClient;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrDocument;
import org.apache.solr.common.SolrDocumentList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * <p>Description:</p>
 *
 * @Author 姚洪斌
 * @Date 2017/9/18 17:05
 */
@Repository
public class ItemSearchDaoImpl implements ItemSearchDao  {

    @Autowired
    private SolrClient solrClient ;

    public SolrResult searchItemByName(SolrQuery solrQuery)  {
        SolrResult<Item> solrResult = new SolrResult<Item>();
        try {
            // 查询并获取查询响应
            QueryResponse queryResponse = solrClient.query(solrQuery);
            // 从响应中获取结果集
            SolrDocumentList solrDocuments = queryResponse.getResults();
            List<Item> items = new ArrayList<Item>();
            if (solrDocuments != null) {
                // 设置查询出来的记录数
                solrResult.setResultCount(solrDocuments.getNumFound());
                for (SolrDocument solrDocument : solrDocuments) {
                    // 创建一个商品集合保存查询到的商品
                    Item item = new Item();
                    // 取出来是String型的数据，不能直接强转成int型
                    item.setItemId(Integer.parseInt((String) solrDocument.get("id")));
                    Map<String,Map<String,List<String>>> highlighting = queryResponse.getHighlighting();
                    System.out.println(highlighting.size());
                    System.out.println(highlighting);
                    if (highlighting != null) {
                        List<String> stringList = highlighting.get(solrDocument.get("id")).get("item_title");
                        if (stringList != null && stringList.size() > 0) {
                            item.setItemTitle(stringList.get(0));
                        } else  {
                            item.setItemTitle((String) solrDocument.get("item_title"));
                        }
                    } else {
                        item.setItemTitle((String) solrDocument.get("item_title"));
                    }
                    item.setImages((String) solrDocument.get("item_image"));
                    item.setPrice((Double) solrDocument.get("item_price"));
                    item.setSales((Integer) solrDocument.get("item_sales"));
                    Merchant merchant = new Merchant();
                    merchant.setMerchantId((Integer) solrDocument.get("merchant_id"));
                    merchant.setMerchantName((String) solrDocument.get("item_merchant"));
                    item.setMerchant(merchant);
                    items.add(item);
                }
            }
            solrResult.setList(items);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return solrResult;
    }
}
