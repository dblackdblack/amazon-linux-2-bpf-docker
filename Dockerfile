FROM quay.io/iovisor/bpftrace:master-vanilla_llvm_clang_glibc2.23 AS bpftrace

FROM amazonlinux:2

RUN true \
    && yes | yum install deltarpm \
    && yes | yum install kernel-headers-$(echo 4.14.181-142.260.amzn2.x86_64 | cut -d'.' -f1-5) \
    && yes | yum install kernel-devel-4.14.181-142.260.amzn2.x86_64 \
    && amazon-linux-extras enable BCC \
    && yes | yum install bcc 

COPY --from=bpftrace ["/usr/local/bin/*.bt", "/usr/local/bin/"]
COPY --from=bpftrace ["/usr/bin/bpftrace", "/usr/local/bin/"]

