package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.sql.DataSource;
import model.Comune;

public class ComuneDAO {

    private DataSource ds;

    public ComuneDAO(DataSource ds) {
        this.ds = ds;
    }

    public List<Comune> findAll() throws SQLException {
        List<Comune> lista = new ArrayList<>();
        String sql = "SELECT id, nome FROM comune ORDER BY nome";

        try (Connection con = ds.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Comune c = new Comune();
                 c.setId(rs.getInt("id"));
                 c.setNomeComune(rs.getString("nome"));
                lista.add(c);
            }
        }
        return lista;
    }
}