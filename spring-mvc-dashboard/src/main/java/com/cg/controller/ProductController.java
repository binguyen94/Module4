package com.cg.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ProductController {

    @GetMapping("/cp/products")
    public String showListPage() {
        return "cp/product/list";
    }


    @GetMapping("/cp/products/create")
    public String showCreatePage() {
        return "cp/product/create";
    }
}
