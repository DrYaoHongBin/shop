package com.shop.been;

public class AjaxResult {

    private boolean success;
    private String message;

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getMessage() {
        return message;
    }
    public boolean getSuccess(){
        return  success;
    }

    public AjaxResult(boolean success, String message){
        this.success = success;
        this.message = message;
    }
}
