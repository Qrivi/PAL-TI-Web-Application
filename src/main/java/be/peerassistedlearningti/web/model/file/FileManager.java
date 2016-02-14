package be.peerassistedlearningti.web.model.file;

import org.springframework.web.multipart.MultipartFile;

import java.io.File;

/**
 * Class used to save and retrieve files
 */
public interface FileManager
{

    /**
     * Gets a file with the specified path from the file manager
     *
     * @param path The path of the file that will be returned
     * @return The file with the specified path
     */
    File getFile( String path );

    /**
     * Saves a file in the file manager and returns its path
     *
     * @param file The file to be saved
     * @return The path of the saved file, when saving fails null is returned
     */
    String saveFile( MultipartFile file );

}
