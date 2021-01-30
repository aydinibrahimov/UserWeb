package com.company.filter;

import com.company.util.ControllerUtil;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebFilter(filterName = "SecurityFileFilter", urlPatterns = {"*"})

public class SecurityFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig)  {

    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) {
        HttpServletRequest req=(HttpServletRequest)request;
        HttpServletResponse res = (HttpServletResponse) response;
        try{
        if(!req.getRequestURI().contains("/login") && req.getSession().getAttribute("loggedInUser")==null){
            res.sendRedirect("login");
        }else{
            chain.doFilter(request,response);
        }}catch (Exception ex){
            ex.printStackTrace();
        }

    }

    @Override
    public void destroy() {

    }
}