import * as functions from 'firebase-functions'
import { IResponse } from './models/moberas_models';
import * as admin from 'firebase-admin';

admin.initializeApp();

export default async (
    snapshot: functions.firestore.DocumentSnapshot,
    context: functions.EventContext
) => {
    const responseDoc = snapshot.data() as IResponse;
    const responseName = responseDoc.activity.name;
    const selectedValue = responseDoc.response.selectedValue;
    const uid = context.params.uid0;
    
    let score = 0;
    switch(responseName){
        case 'nausea': {
            score = responseMulti();
            break;
        }
        case 'evacuation':{
            score = responseYesNo();
            break;
        }
        case 'drinkeat': {
            score = responseMulti();
            break;
        }
        case 'urine': {
            score = responseMulti();
            break;
        }
        case 'wellbeing': {
            score = responseMulti();
            break;
        }
        case 'pain': {
            score = responsePainScale();
            break;
        }
        case 'gas': {
            score = responseYesNo();
            break;
        }
    }
    function responseYesNo(){
        
        if(selectedValue === '1'){
            return 1; 
        }else{
            return 0;
        }
    }
    function responseMulti(){

        if(selectedValue === '1' || '2' || '3'){
            return 1;
        }else{
            return 0;
        }
    }
    function responsePainScale(){

        if(selectedValue === '0' || '1' || '2' || '3' || '4'){
            return 1;
        }else{
            return 0;
        }
    }
    const increment = admin.firestore.FieldValue.increment(score);
    console.log(`Pontuacao => ${score}`);
    return admin.firestore().doc(`users/${uid}`).update({'score':increment});
}
