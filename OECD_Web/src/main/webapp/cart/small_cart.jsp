<%@ page pageEncoding="utf-8" contentType="application/json"%>
{"size": "${sessionScope.cart.getTotalSize()}", "errors":"${sessionScope.error_message}"}