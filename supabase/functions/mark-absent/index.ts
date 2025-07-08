import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js";

serve(async (_req) => {
  const supabase = createClient(
    Deno.env.get("PROJECT_URL")!,
    Deno.env.get("SERVICE_ROLE_KEY")!
  );

  const today = new Date().toISOString().split("T")[0];

  const { error } = await supabase
    .from("attendance")
    .update({ status: "absent" })
    
    .eq("status", "present");

  if (error) {
    return new Response(JSON.stringify({ error }), { status: 500 });
  }
console.log("Function ran, attempting to mark absent");
return new Response("marked absent✔️", { status: 200 });

});
