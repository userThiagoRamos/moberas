import functions = require("firebase-functions");

export const analyticsDynamicSurveyEndFn =
functions.analytics.event('survey_dynamic_end').onLog(async (event, context) => {
    await (await import('./fn/analyticsEventDynamicSurveyEnd')).default(event, context)
})


/**
 * Registra o usuario firebase criado no banco de dados
 */
export const register_user_on_db = functions.runWith({memory:"1GB"}).auth
  .user()
  .onCreate(async (user, context) => {
    await (await import("./fn/on_create_user")).default(user, context);
  });

export const survey_onchange = functions.firestore
  .document("users/{uid0}/private_profile/{uid1}/survey/{uid2}")
  .onUpdate(async (change, context) => {
    await (await import("./fn/survey_onchange ")).default(change, context);
});

export const milestone_answer_handler = functions.firestore
    .document('/users/{uid}/private_profile/{uid1}/survey/{uid2}/milestone_responses/{mid}')
    .onWrite(async (change,context) => {
        await (await import('./fn/milestone_answer_handler')).default(change,context);
});

export const activity_response_handler = functions.firestore
  .document("users/{uid0}/private_profile/{uid1}/survey/{uid2}/activities_responses/{aid}")
  .onCreate(async (change, context) => {
    await (await import("./fn/activity_responses_handler")).default(change, context);
});

export const pacientPush =
functions.https.onCall(async (data, context) => {
    return (await import('./fn/pacient_push')).default(data, context)
})
