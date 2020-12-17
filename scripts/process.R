calc_pi <- function(N) {
    # Estimates pi using Monte-Carlo
    M <- 0
    for(i in 1:N) {
        x <- runif(1, -1, 1)
        y <- runif(1, -1, 1)

        if(x^2 + y^2 < 1) M <- M + 1
    }

    return(4 * M / N)
}


parser <- function(file) {
    # Parses the simulation settings from a file
    conn <- file(file, open="r")
    linn <-readLines(conn)
    close(conn)

    return(as.numeric(linn[1]))
}


writer <- function(val, file) {
    # Writes value to a file
    val_str <- format(val, scientific = FALSE)

    fileConn <- file(file)
    writeLines(val_str, fileConn)
    close(fileConn)
}


N <- parser(snakemake@input[['run']])
pi_approx <- calc_pi(N)
writer(pi_approx, snakemake@output[[1]])