import java.util.HashMap;

public class Slot implements Comparable<Slot>{
    private int settimana;
    private int giorno;
    private int inizio;
    private int fine;
    private String corso;
    private String docente;

    private static final HashMap<Integer, String> giorni = new HashMap<>();
    static{
        giorni.put(1, "lunedi");
        giorni.put(2, "martedi");
        giorni.put(3, "mercoledi");
        giorni.put(4, "giovedi");
        giorni.put(5, "venerdi");
        giorni.put(6, "sabato");
    };
        

    public Slot(int settimana, int giorno, int inizio, int fine, String corso, String docente){
        this.settimana = settimana;
        this.giorno = giorno;
        this.inizio = inizio;
        this.fine = fine;
        this.corso = corso;
        this.docente = docente;
    }

    public int getSettimana(){
        return settimana;
    }

    public int getGiorno(){
        return giorno;
    }

    public int getInizio(){
        return inizio;
    }

    public String toString(){
        return "(" + settimana + ", " + giorni.get(giorno) + ", " + inizio + ", " + fine + ", " + corso + ", " + docente + ")";
    }

    public int compareTo(Slot slot){

        if(settimana - slot.getSettimana() == 0){
            
            if(giorno == slot.getGiorno())
                return inizio - slot.getInizio();
            
            return giorno - slot.getGiorno();
        }
        return settimana - slot.getSettimana();
    }
  }