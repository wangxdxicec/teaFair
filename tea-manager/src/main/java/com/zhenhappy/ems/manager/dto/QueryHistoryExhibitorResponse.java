package com.zhenhappy.ems.manager.dto;

/**
 * query customers by page.
 * <p/>
 * Created by wangxd on 2016-05-24.
 */
public class QueryHistoryExhibitorResponse extends EasyuiResponse {
    private Integer canOperateOwnerFalg;

    public Integer getCanOperateOwnerFalg() {
        return canOperateOwnerFalg;
    }

    public void setCanOperateOwnerFalg(Integer canOperateOwnerFalg) {
        this.canOperateOwnerFalg = canOperateOwnerFalg;
    }
}
