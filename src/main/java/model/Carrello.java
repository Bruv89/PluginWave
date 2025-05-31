package model;

import java.util.*;

public class Carrello {
    private Map<Integer, ElementoCarrello> elementi = new LinkedHashMap<>();

    public void aggiungiProdotto(Prodotto p, int quantita) {
        if (elementi.containsKey(p.getId())) {
            ElementoCarrello ec = elementi.get(p.getId());
            ec.setQuantita(ec.getQuantita() + quantita);
        } else {
            elementi.put(p.getId(), new ElementoCarrello(p, quantita));
        }
    }

    public void rimuoviProdotto(int idProdotto) {
        elementi.remove(idProdotto);
    }

    public void aggiornaQuantita(int idProdotto, int quantita) {
        if (elementi.containsKey(idProdotto)) {
            if (quantita <= 0) {
                rimuoviProdotto(idProdotto);
            } else {
                elementi.get(idProdotto).setQuantita(quantita);
            }
        }
    }

    public void svuota() {
        elementi.clear();
    }

    public Collection<ElementoCarrello> getElementi() {
        return elementi.values();
    }

    public double getTotale() {
        return elementi.values().stream()
                .mapToDouble(ElementoCarrello::getTotale)
                .sum();
    }

    public boolean isVuoto() {
        return elementi.isEmpty();
    }
}


