using Gtk;
using Gee;

public class Application : Gtk.Window {

    public Application () {
        this.title = "My Gtk.TreeView";
        this.window_position = Gtk.WindowPosition.CENTER;
        this.destroy.connect (Gtk.main_quit);
        this.set_default_size (350, 200);

        // Crear un VBox para organizar los widgets verticalmente
        var vbox = new Gtk.Box (Gtk.Orientation.VERTICAL, 5);
        this.add (vbox);

        // Crear el ListStore con una columna de tipo cadena (string)
        var list_store = new Gtk.ListStore (1, typeof (string));
        Gtk.TreeIter iter;

        // Añadir datos al ListStore
        list_store.append (out iter);
        list_store.set (iter, 0, "primero");
        list_store.append (out iter);
        list_store.set (iter, 0, "segundo");
        list_store.append (out iter);
        list_store.set (iter, 0, "tercero");
        list_store.append (out iter);
        list_store.set (iter, 0, "cuarto");
        
        var list_store2 = new Gtk.ListStore (1, typeof (string));
        Gtk.TreeIter iter2;

        // Añadir datos al ListStore
        list_store2.append (out iter2);
        list_store2.set (iter2, 0, "11");
        list_store2.append (out iter2);
        list_store2.set (iter2, 0, "22");
        list_store2.append (out iter2);
        list_store2.set (iter2, 0, "33");
        list_store2.append (out iter2);
        list_store2.set (iter2, 0, "44");
        
        // Crear el TreeView y asignarle el ListStore
        var view = new Gtk.TreeView.with_model (list_store);
        var view2 = new Gtk.TreeView.with_model (list_store2);
        
        var cell = new Gtk.CellRendererText ();
        view.insert_column_with_attributes (-1, "State", cell, "text", 0);
        view.get_selection().set_mode(Gtk.SelectionMode.MULTIPLE);
        
        var cell2 = new Gtk.CellRendererText ();
        view2.insert_column_with_attributes (-1, "State", cell2, "text", 0);
        view2.get_selection().set_mode(Gtk.SelectionMode.MULTIPLE);


        // Añadir el TreeView al VBox
        vbox.pack_start (view, true, true, 0);
        vbox.pack_end (view2, true, true, 0);

        // Crear el botón de eliminar
        var delete_button = new Gtk.Button.with_label ("Eliminar Seleccionados");
        delete_button.margin = 10;
        
        

        // Conectar el botón a la función de callback para eliminar filas
        delete_button.clicked.connect (() => {
            var selection = view.get_selection ();
            Value s= Value (typeof (string));
            Gtk.TreeModel model;
            Gtk.TreeIter itera;
            Gtk.TreeIter itera2;
            var selected_rows = selection.get_selected_rows (null).data;
            for (int i = 0; i<selection.count_selected_rows() ; i++) {
				s="hola";
                list_store.get_iter(out itera,selected_rows);
                while (!selection.iter_is_selected (itera) ) {
					list_store.get_iter(out itera,selected_rows);
					selected_rows.next();
					}
				list_store.get_value(itera,0,out s);
				stdout.printf( " %s ",s.get_string());
                list_store2.append (out itera2);
                list_store2.set (itera2,0,s.get_string());
                selected_rows.next();
                }
               
                
        });

        // Añadir el botón al VBox
        vbox.pack_start (delete_button, false, false, 0);

        this.show_all ();
    }

    public static int main (string[] args) {
        Gtk.init (ref args);
        var app = new Application ();
        app.show_all ();
        Gtk.main ();
        return 0;
    }
}
