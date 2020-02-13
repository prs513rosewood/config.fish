function compress_pdf
  set nargs (count $argv)
  if test $nargs -ne 2
    echo "compress_pdf input output"
    return
  end

  gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook \
  -sOutputFile=$argv[2] $argv[1]
end
