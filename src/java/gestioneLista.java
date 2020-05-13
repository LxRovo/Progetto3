/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.sql.*;
import java.io.*;
import java.util.ArrayList;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.xml.parsers.*;
import org.w3c.dom.*;
import org.xml.sax.SAXException;

/**
 *
 * @author Ziz
 *
 */
public class gestioneLista extends HttpServlet {

    final private String driver = "com.mysql.jdbc.Driver";
    final private String dbms_url = "jdbc:mysql://localhost/";
    final private String database = "test_database";
    final private String user = "root";
    final private String password = "";
    private Connection lista;
    private boolean connected;

    // attivazione servlet (connessione a DBMS)
    public void init() {
        String url = dbms_url + database;
        try {
            Class.forName(driver);
            lista = DriverManager.getConnection(url, user, password);
            connected = true;
        } catch (SQLException e) {
            connected = false;
        } catch (ClassNotFoundException e) {
            connected = false;
        }
    }

    // disattivazione servlet (disconnessione da DBMS)
    public void destroy() {
        try {
            lista.close();
        } catch (SQLException e) {
        }
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet gestioneLista</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet gestioneLista at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     *
     * examples of use: http://localhost:8080/lista/getLista?id=1
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idLista;
        String url;
        String[] url_section;
        // verifica stato connessione a DBMS
        if (!connected) {
            response.sendError(500, "DBMS server error!");
            return;
        }
        // estrazione nominativo da URL
        url = request.getRequestURL().toString();
        url_section = url.split("/");
        idLista = url_section[url_section.length - 1];

        System.out.println(idLista);

        if ("lista".equals(idLista)) {
            response.sendError(400, "Request syntax error!");
            return;
        }
        if (idLista == null) {
            response.sendError(400, "Request syntax error!");
            return;
        }
        if (idLista.isEmpty()) {
            response.sendError(400, "Request syntax error!");
            return;
        }

        try {

            String sql = "SELECT costo, nome, marca FROM prodotti p, lista l WHERE l.idLista =" + idLista + " AND p.idProdotto = l.rifProdotto ";

            // ricerca nominativo nel database
            Statement statement = lista.createStatement();
            ResultSet result = statement.executeQuery(sql);

            ArrayList<Prodotto> spesa = new ArrayList(0);

            while (result.next()) {

                String costo = result.getString("costo");
                String marca = result.getString("marca");
                String nome = result.getString("nome");

                Prodotto prodotto = new Prodotto(costo, marca, nome);

                spesa.add(prodotto);
            }

            result.close();
            statement.close();
            // scrittura del body della risposta
            response.setContentType("text/xml;charset=UTF-8");
            PrintWriter out = response.getWriter();
            try {
                out.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
                out.println("<listaSpesa>");
                if (!spesa.isEmpty()) {
                    for (int i = 0; i < spesa.size(); i++) {
                        Prodotto p = spesa.get(i);
                        
                        out.print("<prodotto>");
                        out.print("<costo>");
                        out.print(p.getCosto());
                        out.println("</costo>");
                        out.print("<nome>");
                        out.print(p.getNome());
                        out.print("</nome>");
                        out.println("</number>");
                        out.print("<marca>");
                        out.print(p.getMarca());
                        out.print("</marca>");
                        out.println("</number>");
                        out.println("</prodotto>");
                    }
                }
                out.println("</listaSpesa>");
            } finally {
                out.close();
            }
            response.setStatus(200); // OK
        } catch (SQLException e) {
            response.sendError(500, "DBMS server error!");
        }
    }
}
