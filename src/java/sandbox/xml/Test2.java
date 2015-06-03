package sandbox.xml;

import java.io.FileReader;
import java.util.ArrayList;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.Unmarshaller;

public class Test2 {

    public static void main(String[] args) throws Exception {

        System.out.println("Output from our XML File: ");
        JAXBContext context = JAXBContext.newInstance(BookStore.class);
        Unmarshaller um = context.createUnmarshaller();
        BookStore bookstore2 = (BookStore) um.unmarshal(new FileReader("book.xml"));
        ArrayList<Book> list = bookstore2.getBooksList();
        for (Book book : list) {
            System.out.println("Book: " + book.getName() + " from " + book.getAuthor());
        }
    }
}
