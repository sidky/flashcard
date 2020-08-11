import * as admin from 'firebase-admin';
import * as functions from 'firebase-functions';
import { QueryDocumentSnapshot } from 'firebase-functions/lib/providers/firestore';

admin.initializeApp(functions.config().firestore);

const store = admin.firestore();

// Noun
export const initializeNoun = functions.firestore.document("nouns/{nounId}").onCreate((snapshot, context) => {
    return store.collection("nouns").doc(context.params.nounId).update({
        "createdAt": admin.firestore.FieldValue.serverTimestamp(),
        "updatedAt": admin.firestore.FieldValue.serverTimestamp(),
    });
});

export const modifyNoun = functions.firestore.document("nouns/{nounId}").onUpdate((change, context) => {
    if (needsModifiedTimestamp(change)) {
        return store.collection("nouns").doc(context.params.nounId).update({
            "updatedAt": admin.firestore.FieldValue.serverTimestamp(),
        });
    } else {
        return Promise.resolve();
    }
});

// Noun forms
export const initializeNounForm = functions.firestore.document("nouns/{nounId}/forms/{formId}").onCreate((snapshot, context) => {
    return store.collection("nouns").doc(context.params.nounId).collection("forms").doc(context.params.formId).update({
        "createdAt": admin.firestore.FieldValue.serverTimestamp(),
        "updatedAt": admin.firestore.FieldValue.serverTimestamp(),
    });
});

export const modifyNounForm = functions.firestore.document("nouns/{nounId}/forms/{formId}").onUpdate((change, context) => {
    if (needsModifiedTimestamp(change)) {
        return store.collection("nouns").doc(context.params.nounId).collection("forms").doc(context.params.formId).update({
            "updatedAt": admin.firestore.FieldValue.serverTimestamp(),
        });
    } else {
        return Promise.resolve();
    }
});

// Verbs
export const initializeVerb = functions.firestore.document("verbs/{verbId}").onCreate((snapshot, context) => {
    return store.collection("verbs").doc(context.params.verbId).update({
        "createdAt": admin.firestore.FieldValue.serverTimestamp(),
        "updatedAt": admin.firestore.FieldValue.serverTimestamp(),
    });
});

export const modifyVerb = functions.firestore.document("verbs/{verbId}").onUpdate((change, context) => {
    if (needsModifiedTimestamp(change)) {
        return store.collection("verbs").doc(context.params.verbId).update({
            "updatedAt": admin.firestore.FieldValue.serverTimestamp(),
        });
    } else {
        return Promise.resolve();
    }
});

// Verb form
export const initializeVerbForm = functions.firestore.document("verbs/{verbId}/forms/{formId}").onCreate((snapshot, context) => {
    return store.collection("verbs").doc(context.params.nounId).collection("forms").doc(context.params.formId).update({
        "createdAt": admin.firestore.FieldValue.serverTimestamp(),
        "updatedAt": admin.firestore.FieldValue.serverTimestamp(),
    });
});

export const modifyVerbForm = functions.firestore.document("verbs/{verbId}/forms/{formId}").onUpdate((change, context) => {
    if (needsModifiedTimestamp(change)) {
        return store.collection("verbs").doc(context.params.nounId).collection("forms").doc(context.params.formId).update({
            "updatedAt": admin.firestore.FieldValue.serverTimestamp(),
        });
    } else {
        return Promise.resolve();
    }
});

function needsModifiedTimestamp(change: functions.Change<QueryDocumentSnapshot>) {
   const before = change.before.data();
   const after = change.after.data();

   return before.updatedAt.isEqual(after.updatedAt);
}