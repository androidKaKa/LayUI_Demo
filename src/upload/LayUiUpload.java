package upload;
import java.io.File;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.alibaba.fastjson.JSONObject;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;



public class LayUiUpload extends HttpServlet {


    private static final long serialVersionUID = 1L;

    // 上传文件存储目录
    private static final String UPLOAD_DIRECTORY = "upload";

    // 上传配置
    private static final int MEMORY_THRESHOLD   = 1024 * 1024 * 3;  // 3MB
    private static final int MAX_FILE_SIZE      = 1024 * 1024 * 40; // 40MB
    private static final int MAX_REQUEST_SIZE   = 1024 * 1024 * 50; // 50MB

    /**
     * Constructor of the object.
     */
    public LayUiUpload() {
        super();
    }

    /**
     * Destruction of the servlet. <br>
     */
    public void destroy() {
        super.destroy(); // Just puts "destroy" string in log
        // Put your code here
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        this.doPost(request, response);
    }

    public synchronized void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 结果json对象
        JSONObject jsonobj = new JSONObject();
        int returnTag = -1;
        String id = request.getParameter("ID");
        System.out.println("id============="+id);
        try {
            System.out.println("==========以下为上传代码============");
            request.setCharacterEncoding("utf-8"); // 设置编码
            response.setCharacterEncoding("utf-8");
            response.setContentType("text/html;charset=UTF-8");
            // 获得磁盘文件条目工厂
            // 配置上传参数
            DiskFileItemFactory factory = new DiskFileItemFactory();
            // 设置内存临界值 - 超过后将产生临时文件并存储于临时目录中
            factory.setSizeThreshold(MEMORY_THRESHOLD);
            // 设置临时存储目录
            factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

            ServletFileUpload upload = new ServletFileUpload(factory);

            // 设置最大文件上传值
            upload.setFileSizeMax(MAX_FILE_SIZE);

            // 设置最大请求值 (包含文件和表单数据)
            upload.setSizeMax(MAX_REQUEST_SIZE);

            // 中文处理
            upload.setHeaderEncoding("UTF-8");

            // 构造临时路径来存储上传的文件
            // 这个路径相对当前应用的目录
            String uploadPath = request.getServletContext().getRealPath("./") + File.separator + UPLOAD_DIRECTORY;


            // 如果目录不存在则创建
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            try {
                // 解析请求的内容提取文件数据
                @SuppressWarnings("unchecked")
                List<FileItem> formItems = upload.parseRequest(request);
                //为什么size 为2？？？
                System.out.println("size "+formItems.size());
                if (formItems != null && formItems.size() > 0) {
                    // 迭代表单数据
                    for (FileItem item : formItems) {
                        System.out.println("item "+item);
                        if(item!=null) {
                            // 处理不在表单中的字段
                            if (!item.isFormField()) {
                                String fileName = new File(item.getName()).getName();
                                String filePath = uploadPath + File.separator + fileName;
                                File storeFile = new File(filePath);
                                // 在控制台输出文件的上传路径
                                System.out.println(filePath);
                                // 保存文件到硬盘
                                item.write(storeFile);
                                jsonobj.put("code", 0);
                                returnTag = 1;
                            }
                        }
                    }
                }
            } catch (Exception ex) {
                jsonobj.put("STATUS", "1");
                System.out.println("fail "+ ex.getMessage());
            }
            System.out.println("return flag "+returnTag);
          if(returnTag != -1) {
                // 请求失败
                jsonobj.put("STATUS", "1");
            } else {
                jsonobj.put("code", 0);
            }


            response.getWriter().write(jsonobj.toString());
            response.getWriter().close();
        } catch (Exception e) {
            e.printStackTrace();
            jsonobj.put("errorCode", 0);
            response.getWriter().write(jsonobj.toString());
            response.getWriter().close();

        }


    }

    /**
     * Initialization of the servlet. <br>
     *
     * @throws ServletException if an error occurs
     */
    public void init(ServletConfig config) throws ServletException {

    }

}