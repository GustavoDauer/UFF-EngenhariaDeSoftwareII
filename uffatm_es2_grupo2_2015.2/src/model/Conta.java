/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author ccz
 */
public class Conta implements DatabaseActions {

    String id, saldo, saldo_centavos, limite, agencia, banco, status, poupanca_status, poupanca, poupanca_centavos;
    String idCliente, numeroCartao, senha;
    ArrayList<Cliente> listaClientes;

    public Conta() {
        listaClientes = new ArrayList();
    }

    public Conta(HttpServletRequest request) {
        id = request.getParameter("id");
        saldo = request.getParameter("saldo");
        saldo_centavos = request.getParameter("saldo_centavos");
        limite = request.getParameter("limite");
        agencia = request.getParameter("agencia");
        banco = request.getParameter("banco");
        status = request.getParameter("status");
        poupanca_status = request.getParameter("poupanca_status");
        poupanca = request.getParameter("poupanca");
        poupanca_centavos = request.getParameter("poupanca_centavos");

        idCliente = request.getParameter("idCliente");
        numeroCartao = request.getParameter("numeroCartao");
        senha = request.getParameter("senha");
        listaClientes = new ArrayList();
    }
    
    public Conta(Conta conta) {
        id = conta.id;
        saldo = conta.saldo;
        saldo_centavos = conta.saldo_centavos;
        limite = conta.limite;
        agencia = conta.agencia;
        banco = conta.banco;
        status = conta.status;
        poupanca_status = conta.poupanca_status;
        poupanca = conta.poupanca;
        poupanca_centavos = conta.poupanca_centavos;

        idCliente = conta.idCliente;
        numeroCartao = conta.numeroCartao;
        senha = conta.senha;
        listaClientes = conta.listaClientes;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getSaldo() {
        return saldo;
    }

    public void setSaldo(String saldo) {
        this.saldo = saldo;
    }

    public String getSaldo_centavos() {
        return saldo_centavos;
    }

    public void setSaldo_centavos(String saldo_centavos) {
        this.saldo_centavos = saldo_centavos;
    }

    public String getLimite() {
        return limite;
    }

    public void setLimite(String limite) {
        this.limite = limite;
    }

    public String getAgencia() {
        return agencia;
    }

    public void setAgencia(String agencia) {
        this.agencia = agencia;
    }

    public String getBanco() {
        return banco;
    }

    public void setBanco(String banco) {
        this.banco = banco;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPoupanca_status() {
        return poupanca_status;
    }

    public void setPoupanca_status(String poupanca_status) {
        this.poupanca_status = poupanca_status;
    }

    public String getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(String idCliente) {
        this.idCliente = idCliente;
    }

    public String getNumeroCartao() {
        return numeroCartao;
    }

    public void setNumeroCartao(String numeroCartao) {
        this.numeroCartao = numeroCartao;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public ArrayList<Cliente> getListaClientes() {
        return listaClientes;
    }

    public void setListaClientes(ArrayList<Cliente> listaClientes) {
        if (listaClientes != null && !listaClientes.isEmpty()) {
            this.listaClientes = listaClientes;
        } else if(!this.id.equals("0") && !this.id.isEmpty() && this.id != null) {
            this.listaClientes = new ArrayList();
            
            Connection conexao = null;
            PreparedStatement stmt;
            String query;
            try {
                conexao = Conexao.conectar();

                query = "SELECT `Conta`.`idConta`,"
                        + "    `Conta`.`saldo`,"
                        + "    `Conta`.`saldo_centavos`,"
                        + "    `Conta`.`limite`,"
                        + "    `Conta`.`agencia`,"
                        + "    `Conta`.`banco`,"
                        + "    `Conta`.`status`,"
                        + "    `Conta`.`poupanca_status`,"
                        + "    `Conta`.`poupanca_saldo`,"
                        + "    `Conta`.`poupanca_saldo_centavos`"
                        + " FROM `BD_ES2`.`Conta` "
                        + "WHERE `idConta` = " + id;
                stmt = conexao.prepareStatement(query);
                ResultSet rs = stmt.executeQuery(query);

                if (rs.next()) {                    
                    query = "SELECT Cliente_idCliente, Conta_idConta, numeroCartao, senha, "
                            + "nome, Cliente.status "
                            + "FROM Cliente_has_Conta "
                            + "INNER JOIN Cliente on idCliente = Cliente_idCliente "
                            + "WHERE Conta_idConta = " + id;

                    stmt = conexao.prepareStatement(query);
                    ResultSet rs2 = stmt.executeQuery(query);

                    while (rs2.next()) {
                        Cliente cliente = new Cliente();
                        cliente.setId(rs2.getString("Cliente_idCliente"));
                        cliente.setNome(rs2.getString("nome"));
                        cliente.setNome(rs2.getString("Cliente.status"));

                        listaClientes.add(cliente);
                    }                                                                   
                }
                
                conexao.close();
            } catch (ClassNotFoundException | InstantiationException | IllegalAccessException | SQLException ex) {                
            }
        }
    }

    public String getPoupanca() {
        return poupanca;
    }

    public void setPoupanca(String poupanca) {
        this.poupanca = poupanca;
    }

    public String getPoupanca_centavos() {
        return poupanca_centavos;
    }

    public void setPoupanca_centavos(String poupanca_centavos) {
        this.poupanca_centavos = poupanca_centavos;
    }

    public void geraNumero() {

    }

    public void geraCartao() {

    }

    @Override
    public boolean insert() {
        Connection conexao = null;
        PreparedStatement stmt;
        String query;
        try {
            conexao = Conexao.conectar();

            query = "INSERT INTO `BD_ES2`.`Conta` "
                    + "("
                    + "`limite`,"
                    + "`agencia`,"
                    + "`banco`,"
                    + "`status`,"
                    + "`poupanca_status`) "
                    + "VALUES"
                    + "("
                    + limite + ","
                    + "'" + agencia + "',"
                    + "'" + banco + "',"
                    + status + ","
                    + poupanca_status + ");";

            stmt = conexao.prepareStatement(query); // Conta
            stmt.executeUpdate(query);

            query = "SELECT MAX(idConta) FROM Conta;";

            ResultSet rs = stmt.executeQuery(query);

            if (rs.next()) {
                id = rs.getString("MAX(idConta)");
                numeroCartao = idCliente; // Pra facilitar, o numero do cartao sera o ID do cliente por enquanto.                

                query = "INSERT INTO `BD_ES2`.`Cliente_has_Conta` "
                        + "(`Cliente_idCliente`,"
                        + "`Conta_idConta`,"
                        + "`numeroCartao`,"
                        + "`senha`)"
                        + "VALUES"
                        + "("
                        + idCliente + "," // ID do cliente primário
                        + id + ",'"
                        + numeroCartao + "','"
                        + senha + "')";

                stmt = conexao.prepareStatement(query); // Cliente_has_Conta
                stmt.executeUpdate(query);
            } else {
                conexao.close();
                return false;
            }

            conexao.close();
            return true;
        } catch (ClassNotFoundException | InstantiationException | IllegalAccessException | SQLException ex) {
            return false;
        }
    }

    @Override
    public boolean edit() {
        Connection conexao = null;
        PreparedStatement stmt;
        String query;
        try {
            conexao = Conexao.conectar();

            query = "UPDATE `BD_ES2`.`Conta` "
                    + "SET "
                    + "`limite` = " + limite + ","
                    + "`agencia` = '" + agencia + "',"
                    + "`banco` = '" + banco + "',"
                    + "`status` = " + status + ","
                    + "`poupanca_status` = " + poupanca_status
                    + " WHERE `idConta` = " + id;

            stmt = conexao.prepareStatement(query);
            stmt.executeUpdate(query);

            if (!idCliente.equals("0")) {
                numeroCartao = idCliente; // Pra facilitar, o numero do cartao sera o ID do cliente por enquanto.  
                
                query = "INSERT INTO `BD_ES2`.`Cliente_has_Conta` "
                        + "(`Cliente_idCliente`,"
                        + "`Conta_idConta`,"
                        + "`numeroCartao`,"
                        + "`senha`)"
                        + "VALUES"
                        + "("
                        + idCliente + "," // ID do cliente primário
                        + id + ",'"
                        + numeroCartao + "','"
                        + senha + "')";

                stmt = conexao.prepareStatement(query); // Cliente_has_Conta
                stmt.executeUpdate(query);
            }

            conexao.close();
            return true;
        } catch (ClassNotFoundException | InstantiationException | IllegalAccessException | SQLException ex) {
            return false;
        }
    }

    @Override
    public boolean delete() {
        Connection conexao = null;
        PreparedStatement stmt;
        String query;
        try {
            conexao = Conexao.conectar();

            query = "DELETE FROM `BD_ES2`.`Conta` "
                    + "WHERE `idConta` = " + id;
            stmt = conexao.prepareStatement(query);
            stmt.executeUpdate(query);

            conexao.close();
            return true;
        } catch (ClassNotFoundException | InstantiationException | IllegalAccessException | SQLException ex) {
            return false;
        }
    }

    @Override
    public boolean view(HttpServletRequest request) {
        Connection conexao = null;
        PreparedStatement stmt;
        String query;
        try {
            conexao = Conexao.conectar();

            query = "SELECT `Conta`.`idConta`,"
                    + "    `Conta`.`saldo`,"
                    + "    `Conta`.`saldo_centavos`,"
                    + "    `Conta`.`limite`,"
                    + "    `Conta`.`agencia`,"
                    + "    `Conta`.`banco`,"
                    + "    `Conta`.`status`,"
                    + "    `Conta`.`poupanca_status`,"
                    + "    `Conta`.`poupanca_saldo`,"
                    + "    `Conta`.`poupanca_saldo_centavos`"
                    + " FROM `BD_ES2`.`Conta` "
                    + "WHERE `idConta` = " + id;
            stmt = conexao.prepareStatement(query);
            ResultSet rs = stmt.executeQuery(query);

            if (rs.next()) {
                Conta conta = new Conta();
                conta.setId(rs.getString("idConta"));
                conta.setAgencia(rs.getString("agencia"));
                conta.setBanco(rs.getString("banco"));
                conta.setLimite(rs.getString("limite"));
                conta.setPoupanca_status(rs.getString("poupanca_status"));
                conta.setSaldo(rs.getString("saldo"));
                conta.setSaldo_centavos(rs.getString("saldo_centavos"));
                conta.setStatus(rs.getString("status"));
                conta.setPoupanca(rs.getString("poupanca_saldo"));
                conta.setPoupanca_centavos(rs.getString("poupanca_saldo_centavos"));

                query = "SELECT Cliente_idCliente, Conta_idConta, numeroCartao, senha, "
                        + "nome "
                        + "FROM Cliente_has_Conta "
                        + "INNER JOIN Cliente on idCliente = Cliente_idCliente "
                        + "WHERE Conta_idConta = " + id;

                stmt = conexao.prepareStatement(query);
                ResultSet rs2 = stmt.executeQuery(query);

                while (rs2.next()) {
                    Cliente cliente = new Cliente();
                    cliente.setId(rs2.getString("Cliente_idCliente"));
                    cliente.setNome(rs2.getString("nome"));

                    conta.listaClientes.add(cliente);
                }

                request.setAttribute("conta", conta);

                conexao.close();
                return true;
            } else {
                //TODO: Consulta vazia (registro já foi deletado)
                conexao.close();
                return false;
            }

        } catch (ClassNotFoundException | InstantiationException | IllegalAccessException | SQLException ex) {
            return false;
        }
    }

    @Override
    public boolean viewAll(HttpServletRequest request) {
        Connection conexao = null;
        PreparedStatement stmt;
        String query;
        try {
            conexao = Conexao.conectar();

            query = "SELECT `Conta`.`idConta`,"
                    + "    `Conta`.`saldo`,"
                    + "    `Conta`.`saldo_centavos`,"
                    + "    `Conta`.`limite`,"
                    + "    `Conta`.`agencia`,"
                    + "    `Conta`.`banco`,"
                    + "    `Conta`.`status`,"
                    + "    `Conta`.`poupanca_status`,"
                    + "    `Conta`.`poupanca_saldo`,"
                    + "    `Conta`.`poupanca_saldo_centavos`"
                    + "FROM `BD_ES2`.`Conta`";
            stmt = conexao.prepareStatement(query);
            ResultSet rs = stmt.executeQuery(query);

            ArrayList<Conta> todasContas = new ArrayList();

            while (rs.next()) {
                Conta conta = new Conta();
                conta.setId(rs.getString("idConta"));
                conta.setAgencia(rs.getString("agencia"));
                conta.setBanco(rs.getString("banco"));
                conta.setLimite(rs.getString("limite"));
                conta.setPoupanca_status(rs.getString("poupanca_status"));
                conta.setSaldo(rs.getString("saldo"));
                conta.setSaldo_centavos(rs.getString("saldo_centavos"));
                conta.setStatus(rs.getString("status"));
                conta.setPoupanca(rs.getString("poupanca_saldo"));
                conta.setPoupanca_centavos(rs.getString("poupanca_saldo_centavos"));

                todasContas.add(conta);
            }

            request.setAttribute("todasContas", todasContas);

            conexao.close();
            return true;
        } catch (ClassNotFoundException | InstantiationException | IllegalAccessException | SQLException ex) {
            return false;
        }
    }
}
