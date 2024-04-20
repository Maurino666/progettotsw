package com.example.mmtswproj;

import java.awt.image.BufferedImage;

import java.io.IOException; 

import java.sql.SQLException;

import jakarta.servlet.http.*;

import jakarta.servlet.*;

import com.example.mmtswproj.model.*;


/**
 * Servlet implementation class ProductControl
 */
public class ProductControl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// ProductModelDS usa il DataSource
	// ProductModelDM usa il DriverManager	
	static boolean isDataSource = true;
	
	static ProductModel model;
	
	static {
		if (isDataSource) {
			model = new ProductModelDS();
		} else {
			model = new ProductModelDM();
		}
	}
	
	public ProductControl() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String dis="/index.jsp";
		
		
		String action = request.getParameter("action");

		try {
			if (action != null) {
				if (action.equalsIgnoreCase("read")) {
					int id = Integer.parseInt(request.getParameter("id"));
					request.removeAttribute("product");
					request.setAttribute("product", model.doRetrieveByKey(id));
					dis="/ProductDetail.jsp";
					
				} else if (action.equalsIgnoreCase("delete")) {
					int id = Integer.parseInt(request.getParameter("id"));
					model.doDelete(id);
					
				} else if (action.equalsIgnoreCase("insert")) {
					String name = request.getParameter("nome");
					String description = request.getParameter("descrizone");
					Double price = Double.parseDouble(request.getParameter("prezzo"));
					int quantity = Integer.parseInt(request.getParameter("quantita"));
					Double iva = Double.parseDouble(request.getParameter("iva"));
					String colore = request.getParameter("colore");
					String category = request.getParameter("categoria");
					String dimension = request.getParameter("dimensioni");

					

					ProductBean bean = new ProductBean();
					bean.setNome(name);
					bean.setDescrizione(description);
					bean.setPrezzo(price);
					bean.setDisponibilita(quantity);
					bean.setFasciaIva(iva);
					bean.setColore(colore);
					bean.setCategoria(category);
					bean.setDimensioni(dimension);
					model.doSave(bean);
				}
			}			
		} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
		}

		
		String sort = request.getParameter("sort");

		try {
			request.removeAttribute("products");
			request.setAttribute("products", model.doRetrieveAll(sort));
		} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
		}

		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(dis);
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
