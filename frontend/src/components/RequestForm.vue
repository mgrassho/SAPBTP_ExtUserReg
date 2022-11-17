<script setup lang="ts">
import FormItem from "./FormItem.vue";
import DocumentationIcon from "./icons/IconDocumentation.vue";
import EcosystemIcon from "./icons/IconEcosystem.vue";
import CommunityIcon from "./icons/IconCommunity.vue";
import SupportIcon from "./icons/IconSupport.vue";
import { useRouter, useRoute } from "vue-router";
import { ref } from "vue";

const API_URL = "/service/ExtUserReg/RegistrationRequest";
const Firstname = ref("");
const Lastname = ref("");
const Email = ref("");
const CompanyName = ref("");
const CompanyID = ref("");
const Reason = ref("");

const router = useRouter();

function confirmation() {
  createRequest();
  router.push("/confirmation");
}

async function createRequest() {
  // Default options are marked with 
  const today = new Date();
  await fetch(API_URL, {
    method: "POST",
    credentials: "same-origin", // include, *same-origin, omit
    headers: {
      "Content-Type": "application/json",
    },
    referrerPolicy: "no-referrer", // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url
    body: JSON.stringify({
      Firstname: Firstname.value,
      Lastname: Lastname.value,
      CompanyName: CompanyName.value,
      CompanyID: CompanyID.value,
      Email: Email.value,
      Reason: Reason.value,
      RegistrationDate: today.toISOString(),
      Status: "N",
    }),
  })
    .then((response) => {
      if (!response.ok) {
        throw new Error(
          "Network response was not OK with status" + response.status
        );
      }
    })
    .catch((error) => console.log(error));
}
</script>

<template>
  <FormItem>
    <template #icon>
      <SupportIcon />
    </template>
    <template #heading>Something about you</template>
    <div class="label">Firstname</div>
    <div><input v-model="Firstname" id="Firstname" /></div>

    <div class="label">Lastname</div>
    <div><input v-model="Lastname" id="Firstname" /></div>

    <div class="label">Email</div>
    <div><input v-model="Email" id="Email" /></div>
  </FormItem>

  <FormItem>
    <template #icon>
      <EcosystemIcon />
    </template>
    <template #heading>Your Company</template>

    <div class="label">Company Name</div>
    <div class="input"><input v-model="CompanyName" id="CompanyName" /></div>

    <div class="label">Company ID</div>
    <div><input v-model="CompanyID" id="CompanyID" /></div>
  </FormItem>

  <FormItem>
    <template #icon>
      <DocumentationIcon />
    </template>
    <template #heading>Tell us why</template>

    <div class="label">Why do you need access?</div>
    <div class="input"><input v-model="Reason" id="Reason" /></div>
  </FormItem>

  <FormItem>
    <template #icon>
      <CommunityIcon />
    </template>
    <template #heading>All done?</template>
    <button @click="confirmation" id="send" role="button">Submit</button>
  </FormItem>
</template>
<style scoped>
.label {
  font-size: 1.1rem;
  font-weight: 300;
  margin-top: 5px;
  color: var(--color-heading);
}

input {
  width: 80%;
  display: block;
  display: inline-block;
  padding: 6px 10px;
  line-height: 100%;
  font-size: 1.2rem;
}

button {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 10px 25px;
  border-radius: 6px;
  border: none;

  font-size: 1.2rem;
  font-weight: 500;

  background: var(--color-button);
  box-shadow: 0px 0.5px 1px rgba(0, 0, 0, 0.1),
    inset 0px 0.5px 0.5px rgba(255, 255, 255, 0.5),
    0px 0px 0px 0.5px rgba(0, 0, 0, 0.12);
  color: #dfdedf;
  user-select: none;
  -webkit-user-select: none;
  touch-action: manipulation;
}

button:focus {
  box-shadow: inset 0px 0.8px 0px -0.25px rgba(255, 255, 255, 0.2),
    0px 0.5px 1px rgba(0, 0, 0, 0.1), 0px 0px 0px 3.5px rgba(58, 108, 217, 0.5);
  outline: 0;
}
</style>
