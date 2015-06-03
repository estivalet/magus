package sandbox.xml;

import java.io.File;
import java.util.ArrayList;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.Marshaller;

public class Test {

    public static void main(String[] args) throws Exception {
        ArrayList<Book> bookList = new ArrayList<Book>();

        // create books
        Book book1 = new Book();
        book1.setIsbn("978-0060554736");
        book1.setName("The Game");
        book1.setAuthor("Neil Strauss");
        book1.setPublisher("Harpercollins");
        bookList.add(book1);

        Book book2 = new Book();
        book2.setIsbn("978-3832180577");
        book2.setName("Feuchtgebiete");
        book2.setAuthor("Charlotte Roche");
        book2.setPublisher("Dumont Buchverlag");
        bookList.add(book2);

        // create bookstore, assigning book
        BookStore bookstore = new BookStore();
        bookstore.setName("Fraport Bookstore");
        bookstore.setLocation("Frankfurt Airport");
        bookstore.setBookList(bookList);

        // create JAXB context and instantiate marshaller
        JAXBContext context = JAXBContext.newInstance(BookStore.class);
        Marshaller m = context.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);

        // Write to System.out
        m.marshal(bookstore, System.out);

        m.marshal(bookstore, new File("book.xml"));

    }

}
