package be.peerassistedlearningti.web.model.file;

import org.apache.commons.io.FilenameUtils;
import org.springframework.util.DigestUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.Date;

/**
 * Class used to save and retrieve files on the disk
 */
public class FileManagerImpl implements FileManager
{

    private static String CATALINA_HOME = System.getProperty( "catalina.home" );
    private static File SAVE_DIR = new File( CATALINA_HOME + File.separator + "files" );

    /**
     * Constructor for FileManagerImpl
     * <p>
     * When creating the save directory fails a RuntimeException is thrown
     */
    public FileManagerImpl()
    {
        if ( !SAVE_DIR.exists() )
        {
            boolean success = SAVE_DIR.mkdirs();
            if ( !success )
                throw new RuntimeException( "Could not make file directory (" + SAVE_DIR + ")" );
        }
    }

    /**
     * Gets a file with the specified path from the file manager
     *
     * @param path The path of the file that will be returned
     * @return The file with the specified path
     */
    public File getFile( String path )
    {
        return new File( path );
    }

    /**
     * Saves a file in the file manager and returns its path
     *
     * @param file The file to be saved
     * @return The path of the saved file, when saving fails null is returned
     */
    public String saveFile( MultipartFile file )
    {
        if ( !file.isEmpty() )
        {
            try
            {
                String originalName = file.getOriginalFilename();
                String extension = FilenameUtils.getExtension( originalName );

                // TODO check valid extensions

                Date now = new Date();
                String name = DigestUtils.md5DigestAsHex( ( originalName + String.valueOf( now.getTime() ) ).getBytes( "UTF-8" ) );
                String path = SAVE_DIR + File.separator + name + "." + extension;

                byte[] multiPartFileBytes = file.getBytes();

                File fileToSave = new File( path );
                BufferedOutputStream stream = new BufferedOutputStream( new FileOutputStream( fileToSave ) );
                stream.write( multiPartFileBytes );
                stream.close();

                return path;
            } catch ( Exception e ) { e.printStackTrace(); }
        }
        return null;
    }
}
