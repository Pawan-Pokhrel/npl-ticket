package com.nplticket.controller.admin;

import com.nplticket.model.UserModel;
import com.nplticket.service.admin.ManageUsersService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(asyncSupported = true, urlPatterns = { "/admin/manage-users" })
public class ManageUsersController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ManageUsersService userService;

    @Override
    public void init() throws ServletException {
        userService = new ManageUsersService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Pagination and search parameters
            int page = 1;
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            }

            int rowsPerPage = 15;
            String rowsPerPageParam = request.getParameter("rowsPerPage");
            if (rowsPerPageParam != null && !rowsPerPageParam.isEmpty()) {
                rowsPerPage = Integer.parseInt(rowsPerPageParam);
                if (rowsPerPage < 1) rowsPerPage = 15;
            }

            String searchTerm = request.getParameter("search") != null ? request.getParameter("search") : "";

            // Fetch users
            List<UserModel> allUsers = userService.getAllUsers(searchTerm);
            int totalUsers = allUsers.size();
            int totalPages = (int) Math.ceil((double) totalUsers / rowsPerPage);
            if (totalPages == 0) totalPages = 1;

            int startIndex = (page - 1) * rowsPerPage;
            int endIndex = Math.min(startIndex + rowsPerPage, totalUsers);
            List<UserModel> paginatedUsers = allUsers.subList(startIndex, endIndex);

            request.setAttribute("users", paginatedUsers);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("searchTerm", searchTerm);
            request.getRequestDispatcher("/WEB-INF/pages/admin/manage-users.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error fetching users: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/admin/manage-users.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            if ("updateRole".equals(action)) {
                Long userId = Long.parseLong(request.getParameter("userId"));
                String role = request.getParameter("role");
                userService.updateUserRole(userId, role);
                request.setAttribute("message", "User role updated successfully!");
            }

            doGet(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid user ID: " + e.getMessage());
            doGet(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error updating role: " + e.getMessage());
            doGet(request, response);
        }
    }
}