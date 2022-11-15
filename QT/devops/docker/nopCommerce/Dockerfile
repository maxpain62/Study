FROM ubuntu as unzip
ADD https://github.com/nopSolutions/nopCommerce/releases/download/release-4.50.3/nopCommerce_4.50.3_NoSource_linux_x64.zip /
RUN apt update && apt install unzip -y && cd / &&\
    mkdir /nop &&\
    cd /nop &&\
    mv /nopCommerce_4.50.3_NoSource_linux_x64.zip /nop/ &&\
    unzip nopCommerce_4.50.3_NoSource_linux_x64.zip &&\
    rm nopCommerce_4.50.3_NoSource_linux_x64.zip

FROM mcr.microsoft.com/dotnet/aspnet:6.0
EXPOSE 80
COPY --from=unzip /nop/ /nop/
WORKDIR /nop
CMD ["dotnet","/nop/Nop.Web.dll"]