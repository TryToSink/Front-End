// ignore_for_file: avoid_print

class BarcosDTO {
  String iDBarco = '';
  String foto1 = '';
  String foto2 = '';
  String foto3 = '';
  String foto4 = '';
  String foto5 = '';
  String nomeBarco = '';
  int tamanho = 0;

  String returnId(){
    return this.iDBarco;
  }

  String returnFoto(int i){
    if(i==0)return foto1;
    else if(i==1)return foto2;
    else if(i==2)return foto3;
    else if(i==3)return foto4;
    else return foto5;
  }
}
