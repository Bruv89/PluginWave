package model;

import java.sql.Timestamp;
import java.util.List;

public class OrdineDTO {
    public int id;
    public Timestamp data;
    public double totale;
    public String indirizzo, citta, cap;
    public String emailUtente;
    public List<RigaOrdineDTO> righe;
}

