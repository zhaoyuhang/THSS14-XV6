#include "shell_gui.h"

// Initialize the buffer of the printer
void
init_printer()
{
    int i;
    for (i = 0; i < LINES; i++) {
        memset(printer_buf[i], 0, sizeof(char) * CHARS);
    }
    for (i = 0; i < 10 * LINES; i++) {
        memset(printer_buf_his[i], 0, sizeof(char) * CHARS);
    }
}

// Clean the screen
void
clean_printer(struct Context context, int draw)
{
    fill_rect(context, 0, HEADERHEIGHT, context.width,
            context.height - HEADERHEIGHT - FOOTERHEIGHT, BACKGROUNDCOLOR);
    if (!draw)
    {
        return;
    }
    if (!isFull)
    {
        fill_rect(context, CHARWIDTH * (char_index + 1), HEADERHEIGHT + CHARHEIGHT * (line_index + 0), CHARWIDTH,
            CHARHEIGHT, CHARCOLOR);
    }
    else
    {
        fill_rect(context, CHARWIDTH * (char_index + 1), HEADERHEIGHT + CHARHEIGHT * (LINES - 1), CHARWIDTH,
            CHARHEIGHT, CHARCOLOR);
    }

}
// Clean the line
void
cleanline_printer(struct Context context, int line, int draw)
{
    fill_rect(context, 0, HEADERHEIGHT + line * CHARHEIGHT, 
        context.width, CHARHEIGHT, BACKGROUNDCOLOR);
    if (!draw)
    {
        return;
    }
    if (!isFull)
    {
        fill_rect(context, CHARWIDTH * (char_index + 1), HEADERHEIGHT + CHARHEIGHT * (line_index + 0), CHARWIDTH,
            CHARHEIGHT, CHARCOLOR);
    }
    else
    {
        fill_rect(context, CHARWIDTH * (char_index + 1), HEADERHEIGHT + CHARHEIGHT * (LINES - 1), CHARWIDTH,
            CHARHEIGHT, CHARCOLOR);
    }

}

// Load the read_buf(0..len-1) into the buffer
// and print strings in the buffer to the screen
void
string_printer(struct Context context, char* read_buf, int len)
{
    int i, j;

    if (len < 0) {
        // If len < 0, delete characters in the buffer
        for (i = 0; i > len; i--) {
            if (char_index > 0) {
                printer_buf[line_index][--char_index] = 0;
                printer_buf_his[linehis_index][--charhis_index] = 0;
            } else {
                break;
            }
        }
    }
    else {
        // Load the read_buf(0..len-1) into the buffer
        for (i = 0; i < len; i++) {
            if (read_buf[i] == '\n') {
                line_index++;
                if (line_index >= LINES) {
                    isFull = 1;
                    line_index = 0;
                }
                char_index = 0;
                linehis_index++;
                if (linehis_index >= 10 * LINES) {
                    isHisFull = 1;
                    linehis_index = 0;
                }
                charhis_index = 0;
                memset(printer_buf[line_index], 0, sizeof(char) * CHARS);
                memset(printer_buf_his[linehis_index], 0, sizeof(char) * CHARS);
                
            } else {
                printer_buf[line_index][char_index++] = read_buf[i];
                printer_buf_his[linehis_index][charhis_index++] = read_buf[i];
                if (char_index >= CHARS) {
                    line_index++;
                    if (line_index >= LINES) {
                        isFull = 1;
                        line_index = 0;
                    }
                    char_index = 0;
                    linehis_index++;
                    if (linehis_index >= 10 * LINES) {
                        isHisFull = 1;
                        linehis_index = 0;
                    }
                    charhis_index = 0;
                }
            }
        }
    }

    clean_printer(context, 1);
    if (!isFull) {
        // The buffer isn't full.
        // Just print 0..line_index lines to the screen.
        for (i = 0; i <= line_index; i++) {
            if (i < line_index) {
                puts_str(context, printer_buf[i], CHARCOLOR,
                    LEFTWIDTH, CHARHEIGHT * i + HEADERHEIGHT);
            }
            else {
                int line_len = strlen(printer_buf[i]);
                int k;
                for (k = 0; k < line_len; k++)
                {
                    if (k < line_len - 1)
                    {
                        put_str(context, printer_buf[i][k], CHARCOLOR,
                            CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * i + HEADERHEIGHT);
                    }
                    else
                    {
                        put_str(context, printer_buf[i][k], CHARCOLOR,
                            CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * i + HEADERHEIGHT);
                    }
                }
            }
        }
    }
    else {
        // The buffer is full.
        // Print (line_index+1)..LINES, 0..line_index lines to the screen.
        for (i = (line_index + 1) % LINES, j = 0; j < LINES; i = (i + 1) % LINES, j++) {
            if (j < line_index - 1) {
                puts_str(context, printer_buf[i], CHARCOLOR,
                    LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
            }
            else {
                int line_len = strlen(printer_buf[i]);
                int k;
                for (k = 0; k < line_len; k++)
                {
                    if (k < line_len - 1)
                    {
                        put_str(context, printer_buf[i][k], CHARCOLOR,
                            CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                    }
                    else
                    {
                        put_str(context, printer_buf[i][k], CHARCOLOR,
                            CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                    }
                }
            }
        }
    }
    curHisLine = linehis_index;
}



// Initialize the windowinfo
void
init_window(struct windowinfo* winfo, char* title)
{
    winfo->id = init_context(&(winfo->context),
            CHARS*CHARWIDTH + LEFTWIDTH + RIGHTWIDTH,
            LINES*CHARHEIGHT + HEADERHEIGHT + FOOTERHEIGHT);
    fill_rect(winfo->context, 0, 0,
            (winfo->context).width, (winfo->context).height, BACKGROUNDCOLOR);
    draw_window(winfo->context, title);
}

// Create the sh to run the command and build pipe between the gui and the sh.
void
create_shell(int* p_pid, int* p_rfd, int* p_wfd)
{
    char *sh_argv[] = { "shell_sh", 0, 0 };
    char rfd[2], wfd[2];
    int gui2sh_fd[2], sh2gui_fd[2];

    memset(rfd, 0, sizeof(char) * 2);
    memset(wfd, 0, sizeof(char) * 2);
    sh_argv[1] = rfd;
    sh_argv[2] = wfd;

    printf(1, "init pipe: starting pipe\n");
    if (pipe(gui2sh_fd) != 0) {
        printf(1, "init gui->sh pipe: pipe() failed\n");
        exit();
    }
    if (pipe(sh2gui_fd) != 0) {
        printf(1, "init sh->gui pipe: pipe() failed\n");
        exit();
    }
    printf(1, "init pipe: pipe is ok\n");

    printf(1, "init sh: starting sh\n");
    *p_pid = fork();
    if (*p_pid < 0) {
        printf(1, "init sh: fork failed\n");
        close(gui2sh_fd[0]);
        close(gui2sh_fd[1]);
        close(sh2gui_fd[0]);
        close(sh2gui_fd[1]);
        exit();
    }
    else if (*p_pid == 0) {
        close(gui2sh_fd[1]);
        rfd[0] = (char)gui2sh_fd[0];
        close(sh2gui_fd[0]);
        wfd[0] = (char)sh2gui_fd[1];
        exec("shell_sh", sh_argv);
        printf(1, "init sh: exec sh failed\n");
        exit();
    }
    else {
        close(gui2sh_fd[0]);
        *p_wfd = gui2sh_fd[1];
        close(sh2gui_fd[1]);
        *p_rfd = sh2gui_fd[0];
    }
}

// Initial the screen

void
init_screen(struct Context context, int rfd)
{
    int total = 0, single = 0;
    char tmp_buf[2];

    init_printer();
    memset(write_cmd, 0, sizeof(char) * COMMANDMAXLEN);
    memset(read_buf, 0, sizeof(char) * READBUFFERSIZE);
    memset(cmd_history, 0, sizeof(char) * 100 * COMMANDMAXLEN);

    // Print the initial string "$ "
    while (total < strlen(init_string)) {
        if ((single = read(rfd, tmp_buf, sizeof(tmp_buf))) > 0) {
            total += single;
            string_printer(context, tmp_buf, single);
        }
    }
}

// Deal with the keydown event
void
handle_keydown(struct Context context, char ch, int rfd, int wfd) {
    int n;
    int k = 0;
    int j;
    if (ch == 8) {
        // ch == 8 is delete. Delete the newest character.
        if (write_index > 0) {
            write_cmd[--write_index] = 0;
            cur_write = write_index - 1;
            string_printer(context, 0, -1);
        }
        return;
    }
    if (ch == '\t')
    {
        return;
    }
    //ch = (256 + ch) % 256;
    int nch = ch + 256;
    int line_len; // = strlen(printer_buf[i]);
    if (nch == KEY_UP || nch == KEY_DN || nch == KEY_LF || nch == KEY_RT || nch == KEY_PGUP || nch == KEY_PGDN || nch == KEY_HOME || nch == KEY_END)
    {
        printf(0, "dd %d\n", ch);

        switch (nch)
        {
            case KEY_HOME:
                //printf(0, "get ");
                clean_printer(context, 0);
                if (!isHisFull && linehis_index < LINES)
                {
                    for (k = 0; k < linehis_index; k++)
                    {
                        puts_str(context, printer_buf_his[k], CHARCOLOR,
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
                    }
                }
                else if (isHisFull)
                {
                    for (k = 0; k < LINES; k++)
                    {
                        puts_str(context, printer_buf_his[(k + linehis_index + 1) % (10 * LINES)], CHARCOLOR,
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
                    }
                }
                else
                {
                    for (k = 0; k < LINES; k++)
                    {
                        puts_str(context, printer_buf_his[k], CHARCOLOR,
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
                    }
                }
                break;
            case KEY_END:
                clean_printer(context, 0);
                if (!isHisFull && linehis_index < LINES)
                {
                    for (k = 0; k < linehis_index; k++)
                    {
                        puts_str(context, printer_buf_his[k], CHARCOLOR,
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
                    }
                }
                else if (isHisFull)
                {
                    for (k = 0; k < LINES; k++)
                    {
                        puts_str(context, printer_buf_his[(k + linehis_index - LINES) % (10 * LINES)], CHARCOLOR,
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
                    }
                }
                else
                {
                    for (k = 0; k < LINES; k++)
                    {
                        puts_str(context, printer_buf_his[(k + linehis_index - LINES) % (10 * LINES)], CHARCOLOR,
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
                    }
                }
                break;
            case KEY_PGUP:
                if (curHisLine <= LINES)
                {
                    break;
                }
                clean_printer(context, 0);
                if (!isHisFull && linehis_index < LINES)
                {
                    for (k = 0; k < linehis_index; k++)
                    {
                        puts_str(context, printer_buf_his[k], CHARCOLOR,
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
                    }
                }
                else if (isHisFull)
                {
                    curHisLine = (curHisLine - LINES) % (10 * LINES);
                    for (k = 0; k < LINES; k++)
                    {
                        puts_str(context, printer_buf_his[(k + curHisLine - LINES) % (10 * LINES)], CHARCOLOR,
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
                    }
                }
                else
                {
                    if (curHisLine > LINES * 2)
                    {
                        curHisLine = curHisLine - LINES;
                    }
                    else
                    {
                        curHisLine = LINES;
                    }
                    for (k = 0; k < LINES; k++)
                    {
                        puts_str(context, printer_buf_his[(k + curHisLine - LINES) % (10 * LINES)], CHARCOLOR,
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
                    }
                }
                break;
            case KEY_PGDN:
                if (curHisLine == linehis_index)
                {
                    break;
                }
                clean_printer(context, 0);
                if (!isHisFull && linehis_index < LINES)
                {
                    for (k = 0; k < linehis_index; k++)
                    {
                        puts_str(context, printer_buf_his[k], CHARCOLOR,
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
                    }
                }
                else if (isHisFull)
                {
                    curHisLine = (curHisLine + LINES) % (10 * LINES);
                    for (k = 0; k < LINES; k++)
                    {
                        puts_str(context, printer_buf_his[(k + curHisLine - LINES) % (10 * LINES)], CHARCOLOR,
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
                    }
                }
                else
                {
                    if (linehis_index - curHisLine >= LINES)
                    {
                        curHisLine = curHisLine + LINES;
                    }
                    else
                    {
                        curHisLine = linehis_index;
                    }
                    for (k = 0; k < LINES; k++)
                    {
                        puts_str(context, printer_buf_his[(k + curHisLine - LINES) % (10 * LINES)], CHARCOLOR,
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
                    }
                }
                break;
            case KEY_RT:
                if (cur_write >= write_index - 1)
                {
                    break;
                }
                cur_write++;
                j = isFull ? (LINES - 1) : (line_index + 0);
                cleanline_printer(context, j, 0);
                line_len = strlen(write_cmd);
                //puts_str(context, "$ ", CHARCOLOR,
                //    LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                 fill_rect(context, CHARWIDTH * (cur_write + 4), HEADERHEIGHT + CHARHEIGHT * (j + 0), 
                    CHARWIDTH, CHARHEIGHT, CHARCOLOR);
                 put_str(context, '$', CHARCOLOR,
                             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                 put_str(context, ' ', CHARCOLOR,
                             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                for (k = 0; k < line_len; k++)
                {
                    if (k != cur_write + 1)
                    {
                        put_str(context, write_cmd[k], CHARCOLOR,
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                    }
                    else
                    {
                        put_str(context, write_cmd[k], BACKGROUNDCOLOR,
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                    }
                }
               break;
            case KEY_LF:
                if (cur_write < 0)
                {
                    break;
                }
                cur_write--;
                j = isFull ? (LINES - 1) : (line_index + 0);
                cleanline_printer(context, j, 0);
                line_len = strlen(write_cmd);
                fill_rect(context, CHARWIDTH * (cur_write + 4), HEADERHEIGHT + CHARHEIGHT * (j + 0), 
                    CHARWIDTH, CHARHEIGHT, CHARCOLOR);
                 puts_str(context, "$ ", CHARCOLOR,
                   LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                 // put_str(context, '$', CHARCOLOR,
                 //             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                 // put_str(context, ' ', CHARCOLOR,
                 //             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                for (k = 0; k < line_len; k++)
                {
                    if (k != cur_write + 1)
                    {
                        put_str(context, write_cmd[k], CHARCOLOR,
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                    }
                    else
                    {
                        put_str(context, write_cmd[k], BACKGROUNDCOLOR,
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                    }
                }
                break;
            case KEY_DN:
                if (cur_his >= his_index)
                {
                    break;
                }
                cur_his++;
                for (k = 0; k < COMMANDMAXLEN; k++)
                {
                    if (cmd_history[cur_his][k] == '\n')
                    {
                        write_index = k;
                        cur_write = k - 1;
                        while (k < COMMANDMAXLEN)
                        {
                            write_cmd[k] = 0;
                            k++;
                        }
                        // k = 0;
                        // while (k + char_index < CHARS)
                        // {
                        //     printer_buf[line_index][k+char_index] = 0;
                        //     k++;
                        // }
                        break;
                    }
                    printer_buf[line_index][char_index] = cmd_history[cur_his][k];
                    char_index++;
                    // if (char_index >= CHARS) {
                    //     line_index++;
                    //     if (line_index >= LINES) {
                    //         isFull = 1;
                    //         line_index = 0;
                    //     }
                    //         char_index = 0;
                    // }
                    write_cmd[k] = cmd_history[cur_his][k];
                }
                j = isFull ? (LINES - 1) : (line_index + 0);
                cleanline_printer(context, j, 0);
                line_len = strlen(write_cmd);
                 puts_str(context, "$ ", CHARCOLOR,
                   LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                 // put_str(context, '$', CHARCOLOR,
                 //             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                 // put_str(context, ' ', CHARCOLOR,
                 //             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                for (k = 0; k < line_len; k++)
                {
                    if (k != write_index)
                    {
                        put_str(context, write_cmd[k], CHARCOLOR,
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                    }
                    else
                    {
                        put_str(context, write_cmd[k], CHARCOLOR,
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                    }
                }
                break;
            case KEY_UP:
                if (cur_his < 0)
                {
                    break;
                }
                //cur_his--;
                //printf(0, "blabla");
                for (k = 0; k < COMMANDMAXLEN - 1; k++)
                {
                    if (cmd_history[cur_his][k] == '\n')
                    {
                        //printf(0, "aaaa");
                        write_index = k;
                        cur_write = k - 1;
                        while (k < COMMANDMAXLEN)
                        {
                            write_cmd[k] = 0;
                            k++;
                        }
                        // k = 0;
                        // while (k + char_index < CHARS)
                        // {
                        //     printer_buf[line_index][k+char_index] = 0;
                        //     k++;
                        // }
                        break;
                    }
                    printer_buf[line_index][char_index] = cmd_history[cur_his][k];
                    char_index++;
                    if (char_index >= CHARS) {
                        line_index++;
                        if (line_index >= LINES) {
                            isFull = 1;
                            line_index = 0;
                        }
                            char_index = 0;
                    }
                    write_cmd[k] = cmd_history[cur_his][k];
                }
                cur_his--;
                j = isFull ? (LINES - 1) : (line_index + 0);
                cleanline_printer(context, j, 0);
                line_len = strlen(write_cmd);
                 puts_str(context, "$ ", CHARCOLOR,
                   LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                 // put_str(context, '$', CHARCOLOR,
                 //             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                 // put_str(context, ' ', CHARCOLOR,
                 //             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                for (k = 0; k < line_len; k++)
                {
                    if (k != write_index)
                    {
                        put_str(context, write_cmd[k], CHARCOLOR,
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                    }
                    else
                    {
                        put_str(context, write_cmd[k], CHARCOLOR,
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                    }
                }
                break;
            default:
                printf(0, "unknown error");
                break;
        }
        //string_printer(context, &ch, 0);

        return;
    }

    printf(0, "%d\n", ch);
    // append the ch to the command and display the command
// for (k = write_index; k > cur_write + 1; k--)
// {
//     write_cmd[k+1] = write_cmd[k];
// }
// write_cmd[k] = ch;
// write_index++;
// cur_write++;
    cur_write = write_index;
    write_cmd[write_index++] = ch;
    string_printer(context, &ch, 1);

    // If user input a '\n', the command will be sent to the sh
    // and the printer will show the result.
    if (ch == '\n') {
        if (write(wfd, write_cmd, strlen(write_cmd)) != strlen(write_cmd)) {
            printf(1, "gui pipe write: failed");
        }
        else {
            // Read the result until get the initial string "$ "
            while (1) {
                if ((n = read(rfd, read_buf, READBUFFERSIZE)) > 0) {
                    string_printer(context, read_buf, n);
                    // if the read_buf ends with init_string("$ "),
                    // the result is over and stop reading.
                    if (read_buf[n - 2] == init_string[0]
                            && read_buf[n - 1] == init_string[1]) {
                        break;
                    }
                }
            }
        }
        his_index++;
        if (his_index >= 100)
        {
            his_index = 0;
        }
        cur_his = his_index;
        //int k = 0;
        for (k = 0; k < COMMANDMAXLEN; k++)
        {
            cmd_history[his_index][k] = write_cmd[k];
        }
        // Clean the write_cmd buffer
        memset(write_cmd, 0, sizeof(char) * COMMANDMAXLEN);
        write_index = 0;
        cur_write = -1;
    }

    char toolongcmdhint[] = "\nThe command is too long!\n";
    // The command cannot be longer than write_len.
    // Otherwise show the hint and clean the write_cmd buffer.
    if (strlen(write_cmd) == COMMANDMAXLEN - 1) {
        // Print the hint
        string_printer(context, toolongcmdhint, strlen(toolongcmdhint));
        // Clean the write_cmd buffer
        memset(write_cmd, 0, sizeof(char) * COMMANDMAXLEN);
        write_index = 0;
        cur_write = -1;
    }
}

void h_closeWnd(Point p) {
    isRun = 0;
}

void addWndEvent(ClickableManager *cm) {
    int i;
    int n = sizeof(wndEvents) / sizeof(Handler);
    for (i = 0; i < n; i++) {
        printf(0, "adding handler\n");
        loadBitmap(&wndRes[i].pic, wndRes[i].name);
        createClickable(cm,
                initRect(wndRes[i].position_x, wndRes[i].position_y,
                        wndRes[i].pic.width, wndRes[i].pic.height), MSG_LPRESS,
                wndEvents[i]);
    }
}

int
main(int argc, char *argv[])
{
    struct windowinfo winfo;
    int sh_pid, rfd, wfd;

    init_window(&winfo, "I'm a SHELL");
    create_shell(&sh_pid, &rfd, &wfd);
    init_screen(winfo.context, rfd);

    cm = initClickManager(winfo.context);
    deleteClickable(&cm.left_click, initRect(0, 0, 800, 600));
    addWndEvent(&cm);

    char write_cmd_ch;
    while (isRun) {
        getMsg(&(winfo.msg));
        switch(winfo.msg.msg_type) {
            case MSG_UPDATE:
                printf(1, "msg_detail %d\n", winfo.msg.msg_detail);
                updateWindow(winfo.id, winfo.context.addr, winfo.msg.msg_detail);
                break;
            case MSG_LPRESS:
                p = initPoint(winfo.msg.concrete_msg.msg_mouse.x,
                    winfo.msg.concrete_msg.msg_mouse.y);
                executeHandler(cm.left_click, p);
                break;
            case MSG_KEYDOWN:
                write_cmd_ch = winfo.msg.concrete_msg.msg_key.key;
                handle_keydown(winfo.context, write_cmd_ch, rfd, wfd);
                updateWindow(winfo.id, winfo.context.addr, winfo.msg.msg_detail);
                break;
            case MSG_PARTIAL_UPDATE:
                updatePartialWindow(winfo.id, winfo.context.addr,
                        winfo.msg.concrete_msg.msg_partial_update.x1,
                        winfo.msg.concrete_msg.msg_partial_update.y1,
                        winfo.msg.concrete_msg.msg_partial_update.x2,
                        winfo.msg.concrete_msg.msg_partial_update.y2);
                break;
            default:
                break;
        }
    }

    free_context(&(winfo.context), winfo.id);
    exit();
}