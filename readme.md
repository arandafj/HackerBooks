#HackerBooks
Lector de libros en PDF para iPad e iPhone. Los libros se descargan de un enlace ofrecido. 

Se ha creado la clase Book, que contiene los datos del libro. Y la clase Library que contiene los libros. 


##isKindOfClass métodos alternativos
Podemos emplear un cast en su forma segura **as?**, empleando si da un formato incorrecto **nil**.

##¿Dónde guardarías los datos en local?
El fichero json en la carpeta Documents de la App. Y las imágenes y PDFs en la carpeta Cache. 

##Persistir la propiedad isFavorite 
He usado NSUserDefaults. Y por orden de sencillez también se puede emplear:

- Modificando el json local y añadiendo una propiedad más a cada libro.
- Core Data.

##Enviar información de Book a Library
He usado el Delegado, que implica una referencia a su delegado, por lo que es más intuitivo a la hora de mantener el código. 
También se podría emplear las Notificaciones, que puede ser que no lleguen al destino.

##Actualización de la tabla
El método reloadData recarga unicamente las celdas que se ven en pantalla. Cuando nos desplazamos por la tabla los datos que se obtienen son unicamente los que están en pantalla. Por eso no supone una aberración. 
Hay otros métodos como reloadSections y reloadRowAtIndex pero tienen animaciones y consumen mas recursos.

##Cómo actualizarías SimplePDFViewController
Enviando una notificación.

##Extra

- Un cambio de diseño de la interfaz más limpio y universal. Refactoring de código para que sea más legible y fácil de mantener. 
- Busqueda en la tabla. 
- Permitir guardar la posición del pdf.
- Permitir añadir y elimilar pdf.  
- Posibilidad de compartir anotaciones con otras personas.  
- Posibilidad de compra. 
- Posibilidad de puntuar los libros.
- Integración con cloud (Drive, Dropbox, iCloud, OneDrive..) 











