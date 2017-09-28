<?php

$filename = 'c:\data';
if (file_exists($filename)) {
    echo "The directory $filename exists";
} else {
    echo "The directory $filename does not exist";
}
?>