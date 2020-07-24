import java.io.File;
import java.io.PrintWriter;
import java.util.Scanner; 
import java.util.ArrayList;
import java.util.Collections;

public class Parser{
    private static final int ORE_RICHIESTE = 364;
    private static final int MAX_ORE_DISPONIBILI = 376;

    public static void main(String[] args){
        File input = new File("output.txt");
        File output_parsed = new File("output_parsed.txt");

        ArrayList<Slot> slots = new ArrayList<>();

        try{
            PrintWriter printWriter = new PrintWriter(output_parsed);
            Scanner sc = new Scanner(input).useDelimiter("\\s");
            while (sc.hasNext()){
                String s = sc.next();
                if(s.length() == 0)
                    continue;
                s = s.substring(5, s.length() - 1);
                String[] p = s.split(",");
                Slot slot = new Slot(Integer.parseInt(p[0]), Integer.parseInt(p[1]), Integer.parseInt(p[2]), Integer.parseInt(p[3]), p[4], p[5]);
                slots.add(slot);
            }
            sc.close();

            Collections.sort(slots);
            int settimana_prima = 1;
            int sum = 0;
            for(Slot slot : slots){
                if(slot.getSettimana() != settimana_prima)
                    printWriter.println("");
                printWriter.println(slot.toString());
                settimana_prima = slot.getSettimana();
                if(slot.getInizio() == 13)
                    sum += 1;
                else
                    sum += 2;
            }
            printWriter.println("\n" + String.valueOf(sum) + "/" + MAX_ORE_DISPONIBILI);
            printWriter.close();

        }catch(Exception e){
            e.printStackTrace();
        }
  }
}