package es.studium.PracticaTema4;

/**
*
* @author Jorge
* Libro
* Representa un libro
* Incluye identificador del libro, t�tulo, autor y precio
*
*/
public class Libro
{
   private int id;
   private String titulo;
   private double precio;
   public Libro()
   {
       setId(0);
       titulo = "";
       precio = 0.0;
   }
   public Libro(int i, String t, double p)
   {
       setId(i);
       titulo = t;
       precio = p;
   }
   public String getTitulo()
   {
       return titulo;
   }

   public double getPrecio()
   {
       return precio;
   }
   public int getId()
   {
       return id;
   }
   public void setId(int id)
   {
       this.id = id;
   }
}