# .latexmkrc starts
#
# No pdf file requested to be made by pdflatex
# Possible values: 
#     0 don't create pdf file
#     1 to create pdf file by pdflatex
#     2 to create pdf file by ps2pdf
#     3 to create pdf file by dvipdf
$pdf_mode = 1;

# Commands to invoke latex, pdflatex
$pdflatex = join(" ",
    "xelatex",
    "-file-line-error",
    "--shell-escape",
    "-src-specials",
    "-synctex=1",
    "-interaction=nonstopmode %O %S;cp %D %R.pdf"
);

# Whether to use recorder option on latex/pdflatex
$recorder = 1;

# 预览
#$pdf_previewer = "SumatraPDF -reuse-instance -inverse-search -a %O %S";
#$pdf_previewer = "open -a %S";

# 连续编译模式
#$preview_continuous_mode = 1;

# 根据不同平台选择不同的更新模式(windows文件占用不能直接覆盖)
#$pdf_update_method = 0;

# 清理文件后缀名
#     space separated extensions of files that are
#     to be deleted when doing cleanup, beyond
#     standard set
$clean_ext = join(" ",
    "acn ", 
    "acr ",
    "alg ",
    "aux ",
    "bbl ",
    "bcf ",
    "blg ",
    "brf ",
    "glg ",
    "glo ",
    "gls ",
    "idx ",
    "ilg ",
    "ind ",
    "ist ",
    "lof ",
    "log ",
    "lot ",
    "out ",
    "toc ",
    "dvi ",
    "run.xml ",
    "synctex.gz ",
    "fdb_latexmk "
);

# 清理模式
# No cleanup of nonessential LaTex-related files.
#     $cleanup_mode = 0: no cleanup
#     $cleanup_mode = 1: full cleanup 
#     $cleanup_mode = 2: cleanup except for dvi,
#                    dviF, pdf, ps, & psF 
#$cleanup_mode = 1;
 
# Directory for output files.  
# Cf. --output-directory of current (pdf)latex
$out_dir = ".build-latexmk";

# 指定生成PDF文件的文件名，可以与LaTeX主文件名不一致
#$jobname = "Book";

# .latexmkrc end
