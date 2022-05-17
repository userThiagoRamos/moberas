import * as admin from 'firebase-admin';
import * as functions from 'firebase-functions';

admin.initializeApp();
const firestore = admin.firestore();
const messaging = admin.messaging();
export default async (
    data: any,
    context: functions.https.CallableContext
) => {
    try {
    //Recupera o uid e mensagem 
    //(verificar no projeto caderneta da mulher a construcao[servico de autenticacao] do objeto callable function 
    //sua chamada e definicao do argumento para envio)
    const uid = data.uid;
    const msgAdmin = data.msg;

    console.log(uid);
    //recupera o perfil 
    const userProfile = await firestore.doc(`users/${uid}`).get();
    const fcmToken = userProfile.data()?.fcmToken;
    const message = {
        notification: {
          title: 'MobEras',
          body: msgAdmin,
        },
        token: fcmToken
      };
    await messaging.send(message);
    return { success: true }    
    } catch (error) {
        console.error(error);
        return {success:false};
        
    }
    
}