#define T_DIR  1   // Directory
#define T_FILE 2   // File
#define T_DEV  3   // Device

struct stat {
  short type;  // Type of file
  short nlink; // Number of links to file
  short dev;     // File system's disk device
  short ino;    // Inode number
  uint ctime;
  uint size;   // Size of file in bytes
};
