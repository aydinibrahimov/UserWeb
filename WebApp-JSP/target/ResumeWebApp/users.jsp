<%--
    Document   : user
    Created on : Nov 24, 2020, 10:40:29 AM
    Author     :  aydinibrahimov
--%>

<%@page import="com.company.main.Context" %>
<%@page import="com.company.entity.User" %>
<%@page import="com.company.dao.inter.UserDaoInter" %>
<%@page import="com.company.dao.impl.UserDaoImpl" %>
<%@ page import="java.util.List" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="/Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <link rel="stylesheet" href="assets/css/users.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" integrity="sha512-HK5fgLBL+xu6dm/Ii3z4xhlSUyZgTT9tuc/hSrtw6uzJOvgRr2a9jyxxT1ely+B+xFAmJKVSTbpM/CuL7qxO8w==" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script type="text/javascript" src="assets/js/users.js" ></script>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</head>
<body>
<% UserDaoInter userDao = Context.instanceUserDao();
    String name = request.getParameter("name");
    String surname = request.getParameter("surname");
    String nationalityIdStr = request.getParameter("id");
    Integer nationalityId = null;
    if (nationalityIdStr != null && !nationalityIdStr.trim().isEmpty()) {
        nationalityId = Integer.parseInt(nationalityIdStr);
    }
    List<User> list = userDao.getAll(name, surname, nationalityId);
%>
<div class="container">


    <!-- Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Delete</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    Are you sure?!
                </div>
                <div class="modal-footer">
                    <form action="userdetail" method="POST">
                        <input type="hidden" name="id" value="" id="idForDelete"/>
                        <input type="hidden" name="action" value="delete">
                    <button style="background:green" type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <input  type="submit" class="btn btn-danger" value="Delete"/>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-4">
            <form action="users.jsp" method="GET">
                <div class="form-group">
                    <label for="name">name:</label>
                    <input onkeyup="writeWhatIamTyping()" placeholder="enter name" class="form-control" type="text" name="name" value="" />

                </div>
                <br/>
                <div class="form-group">
                    <label for="surname">surname:</label>
                    <input placeholder="enter surname" class="form-control" type="text" name="surname" value=""/>
                </div>

                <input visible="true" class="btn btn-primary" type="submit" name="search" value="Search" id="search"/>
               </form>
        </div>
    </div>

    <div>
        <table class="table">
            <thead>
            <tr>
                <th>name</th>
                <th>surname</th>
                <th>nationality</th>
                <th></th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            <% for (User u : list){ %>
            <tr>
                <td><%=u.getName()%>
                </td>

                <td><%=u.getSurname()%>
                </td>

                <td><%=u.getNationality().getName()== null ? "N/A" : u.getNationality().getName()%>
                </td>

                <td style="width: 5px">

                        <input type="hidden" name="id" value="<%=u.getId()%>"/>
                        <input type="hidden" name="action" value="delete" />
                    <button class="btn btn-danger" type="submit" value="delete" data-toggle="modal" data-target="#exampleModal"
                            onclick="setIdForDelete(<%=u.getId()%>)">
                        <i class="fas fa-trash-alt" ></i></button>

                </td>
                <td style="width: 5px">
                    <form action="userdetail"  method="GET">

                        <input type="hidden" name="id" value="<%=u.getId()%>"/>
                      <input type="hidden" name="action"  value="update" />
                        <button class="btn btn-secondary" type="submit" value="update"  >
                            <i class="fas fa-pen-square"></i>
                        </button>
                    </form>
                </td>
            </tr>
            <%}%>
            </tbody>
        </table>

    </div>
</div>
</body>

</html>
